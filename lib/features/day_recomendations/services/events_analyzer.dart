import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_recomendations/models/recommendation.dart';
import 'package:day_planner/features/day_recomendations/models/recommendation_type.dart';
import 'package:day_planner/features/day_recomendations/models/repeated_time_slot.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:flutter/material.dart';

class EventsAnalyzer {
  // Анализ данных за неделю и определение, каких активностей не хватает
  Map<String, dynamic> analyzeUserActivities(List<DayEvent> events) {
    int totalSteps = 0;
    int totalHeartRate = 0;
    double totalKcal = 0;
    int activityCount = 0;

    Map<String, int> categoryCount = {};

    for (var event in events) {
      if (event.healthModel != null) {
        totalSteps += event.healthModel?.totalSteps ?? 0;
        totalHeartRate += event.healthModel?.averageHeartRate ?? 0;
        totalKcal += event.healthModel?.totalKcal ?? 0;
        activityCount++;
      }
      if (!categoryCount.containsKey(event.category)) {
        categoryCount[event.category] = 0;
      }
      categoryCount[event.category] = categoryCount[event.category]! + 1;
    }

    return {
      'totalSteps': totalSteps,
      'totalKcal': totalKcal,
      'averageHeartRate': activityCount > 0 ? totalHeartRate ~/ activityCount : 0,
      'categoryCount': categoryCount,
    };
  }

  double normalizeValue(num value, num min, num max) {
    return max == min ? 0 : (value - min) / (max - min);
  }

  // Нормализация данных
  Map<String, double> normalize(Map<String, dynamic> analysis, Map<String, dynamic> thresholds) {
    return {
      'steps': normalizeValue(analysis['totalSteps'], 0, thresholds['steps']!),
      'heartRate': normalizeValue(analysis['averageHeartRate'], 0, thresholds['heartRate']!),
      'kcal': normalizeValue(analysis['totalKcal'], 0, thresholds['kcal']!),
      'sport': normalizeValue(analysis['categoryCount']['sport'] ?? 0, 0, thresholds['sport']!),
      // Добавьте другие категории по мере необходимости
    };
  }

  // Агрегация оценок
  double aggregateScores(Map<String, double> normalizedValues, Map<String, double> weights) {
    double score = 0.0;
    normalizedValues.forEach((key, value) {
      score += value * weights[key]!;
    });
    return score;
  }

  List<Recommendation> recommendActivities(List<DayEvent> events, Map<String, double> weights) {
    Map<String, dynamic> analysis = analyzeUserActivities(events);

    // Пример пороговых значений для нормализации
    Map<String, dynamic> thresholds = {
      'steps': 65000, // Пороговое значение для общего количества шагов за неделю
      'kcal': 19000.0,
      'heartRate': 80,
      'sport': 5,
      // Добавьте другие категории по мере необходимости
    };

    Map<String, double> normalizedValues = normalize(analysis, thresholds);
    double score = aggregateScores(normalizedValues, weights);

    List<Recommendation> recommendations = [];

    // Определение порога для общего показателя
    double overallThreshold = 0.7;

    // Обязательные рекомендации
    if (score < overallThreshold) {
      if (normalizedValues['steps']! < 0.7) {
        final rec = Recommendation(
          recommendationType: RecommendationType.steps,
          isPositive: false,
          value: normalizedValues['steps']!,
        );
        recommendations.add(rec);
      }
      if (normalizedValues['sport']! < 0.7) {
        final rec = Recommendation(
          recommendationType: RecommendationType.sportActivity,
          isPositive: false,
          value: normalizedValues['sport']!,
        );
        recommendations.add(rec);
      }
      if (normalizedValues['kcal']! < 0.7) {
        final rec = Recommendation(
          recommendationType: RecommendationType.kcal,
          isPositive: false,
          value: normalizedValues['kcal']!,
        );
        recommendations.add(rec);
      }
    }

    return recommendations;
  }

  List<DayEvent> createActivities({
    required List<Recommendation> recommendations,
    required List<DayEvent> events,
    required List<DayEvent> allAnalysisRangeEvent,
    required DateTime recommendationStart,
    required DateTime recommendationEnd,
  }) {
    // Проанализировать занятые часы
    List<DateTimeRange> occupiedTimeRanges = events.map((e) => DateTimeRange(start: e.from, end: e.to)).toList();

    // Определить повторяющиеся временные слоты для каждой активности
    Map<int, List<RepeatedTimeSlot>> repeatedTimeSlots = {};

    for (var event in allAnalysisRangeEvent) {
      String category = event.category;
      int hour = event.from.hour;

      if (!repeatedTimeSlots.containsKey(hour)) {
        repeatedTimeSlots[hour]!.add(RepeatedTimeSlot(category));
      } else {
        final list = repeatedTimeSlots[hour]!.map((e) {
          if (e.category == category) {
            e.increment();
          }
          return e;
        }).toList();
        repeatedTimeSlots[hour] = list;
      }
    }

    List<DayEvent> newEvents = [];

    DateTime currentTime = recommendationStart;

    while (currentTime.isBefore(recommendationEnd)) {
      bool isOccupied =
          occupiedTimeRanges.any((range) => currentTime.isAfter(range.start) && currentTime.isBefore(range.end));

      if (!isOccupied) {
        for (var rec in recommendations) {
          String category = _getCategoryFromRecommendationType(rec.recommendationType);

          // Избегаем повторяющиеся временные промежутки
          if ((repeatedTimeSlots[currentTime.hour]?.length ?? 0) > 5) {
            if (repeatedTimeSlots[currentTime.hour]!.any((e) => e.count > 5)) {
              continue;
            }
          }

          double intensity = (0.7 - rec.value).clamp(0.0, 1.0);

          if (intensity > 0) {
            int steps = rec.recommendationType.isSteps ? (10000 * intensity).toInt() : 0;
            int heartRate = rec.recommendationType.isSteps ? (150 * intensity).toInt() : 0;
            int kcal = rec.recommendationType.isKcal ? (500 * intensity).toInt() : 0;

            String name;
            if (intensity > 0.6) {
              name = 'Intense $category Activity';
            } else if (intensity > 0.3) {
              name = 'Moderate $category Activity';
            } else {
              name = 'Light $category Activity';
            }

            newEvents.add(DayEvent(
              name: name,
              category: category,
              from: currentTime,
              to: currentTime.add(const Duration(hours: 1)),
              healthModel: null,
              docId: '',
            ));
          }
        }
      }

      currentTime = currentTime.add(const Duration(hours: 1));
    }

    return newEvents;
  }

  String _getCategoryFromRecommendationType(RecommendationType type) {
    switch (type) {
      case RecommendationType.steps:
        return 'sport';
      case RecommendationType.kcal:
        return 'sport';
      case RecommendationType.sportActivity:
        return 'sport';
      default:
        return 'unknown';
    }
  }
}

void main() {
  List<DayEvent> events = [
    DayEvent(
      name: 'Football',
      category: 'sport',
      from: DateTime.now().subtract(const Duration(days: 2)),
      to: DateTime.now().subtract(const Duration(days: 2, hours: -1)),
      healthModel: const HealthModel(totalSteps: 5000, averageHeartRate: 120),
      docId: '',
    ),
    DayEvent(
      name: 'Meeting',
      category: 'work',
      from: DateTime.now().subtract(const Duration(days: 1)),
      to: DateTime.now().subtract(const Duration(days: 1, hours: -1)),
      healthModel: const HealthModel(totalSteps: 200, averageHeartRate: 80),
      docId: '',
    ),
    DayEvent(
      name: 'Writing diploma',
      category: 'study',
      from: DateTime.now().subtract(const Duration(days: 3)),
      to: DateTime.now().subtract(const Duration(days: 3, hours: -1)),
      healthModel: const HealthModel(totalSteps: 50, averageHeartRate: 70),
      docId: '',
    ),
    DayEvent(
      name: 'Reading',
      category: 'rest',
      from: DateTime.now().subtract(const Duration(days: 4)),
      to: DateTime.now().subtract(const Duration(days: 4, hours: -1)),
      healthModel: const HealthModel(totalSteps: 35, averageHeartRate: 68),
      docId: '',
    ),
    DayEvent(
      name: 'Fishing',
      category: 'rest',
      from: DateTime.now().subtract(const Duration(days: 5)),
      to: DateTime.now().subtract(const Duration(days: 5, hours: -2)),
      healthModel: const HealthModel(totalSteps: 30, averageHeartRate: 68),
      docId: '',
    ),
  ];

  Map<String, double> weights = {
    'steps': 0.3,
    'kcal': 0.3,
    'heartRate': 0.2,
    'sport': 0.2,
  };

  EventsAnalyzer recommendationSystem = EventsAnalyzer();
  List<Recommendation> recommendations = recommendationSystem.recommendActivities(events, weights);

  for (var recommendation in recommendations) {
    print(recommendation);
  }
}
