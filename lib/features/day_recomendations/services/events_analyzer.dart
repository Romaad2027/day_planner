import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_recomendations/models/recommendation.dart';
import 'package:day_planner/features/day_recomendations/models/recommendation_type.dart';
import 'package:day_planner/features/day_recomendations/models/repeated_time_slot.dart';
import 'package:day_planner/features/profile/models/health_thresholds.dart';
import 'package:flutter/material.dart';

class EventsAnalyzer {
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

  Map<String, double> normalize(Map<String, dynamic> analysis, Map<String, dynamic> thresholds) {
    return {
      'steps': normalizeValue(analysis['totalSteps'], 0, thresholds['steps']!),
      'heartRate': normalizeValue(analysis['averageHeartRate'], 0, thresholds['heartRate']!),
      'kcal': normalizeValue(analysis['totalKcal'], 0, thresholds['kcal']!),
      'sport': normalizeValue(analysis['categoryCount']['sport'] ?? 0, 0, thresholds['sport']!),
    };
  }

  double aggregateScores(Map<String, double> normalizedValues, Map<String, double> weights) {
    double score = 0.0;
    normalizedValues.forEach((key, value) {
      score += value * weights[key]!;
    });
    return score;
  }

  List<Recommendation> recommendActivities(
      List<DayEvent> events, Map<String, double> weights, HealthThresholds healthThresholds) {
    Map<String, dynamic> analysis = analyzeUserActivities(events);

    Map<String, dynamic> thresholds = {
      'steps': healthThresholds.steps,
      'kcal': healthThresholds.kcal,
      'heartRate': healthThresholds.heartRate,
      'sport': 5,
    };

    Map<String, double> normalizedValues = normalize(analysis, thresholds);
    double score = aggregateScores(normalizedValues, weights);

    List<Recommendation> recommendations = [];

    double overallThreshold = 0.7;

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
    required TimeOfDay recommendationStart,
    required TimeOfDay recommendationEnd,
    required DateTime day,
  }) {
    // Проанализировать занятые часы
    List<DateTimeRange> occupiedTimeRanges = events.map((e) => DateTimeRange(start: e.from, end: e.to)).toList();

    // Определить повторяющиеся временные слоты для каждой активности
    Map<int, List<RepeatedTimeSlot>> repeatedTimeSlots = {};

    for (var event in allAnalysisRangeEvent) {
      String category = event.category;
      int hour = event.from.hour;

      if (repeatedTimeSlots.containsKey(hour)) {
        final list = repeatedTimeSlots[hour]!.map((e) {
          if (e.category == category) {
            e.increment();
          }
          return e;
        }).toList();
        repeatedTimeSlots[hour] = list;
      } else {
        repeatedTimeSlots[hour] = [];
        repeatedTimeSlots[hour]!.add(RepeatedTimeSlot(category));
      }
    }

    List<DayEvent> newEvents = [];

    TimeOfDay currentTime = recommendationStart;

    bool intenseSportAdded = false;
    // while (currentTime.hour < recommendationEnd.hour) {
    final checkDate = DateTime(
      day.year,
      day.month,
      day.day,
      currentTime.hour,
      currentTime.minute,
    );
    bool isOccupied =
        occupiedTimeRanges.any((range) => checkDate.isAfter(range.start) && checkDate.isBefore(range.end));

    if (!isOccupied) {
      int counter = 0;
      int idCounter = 0;
      for (var rec in recommendations) {
        final fullDate = DateTime(
          day.year,
          day.month,
          day.day + 1,
          currentTime.hour,
          currentTime.minute,
        );
        String category = _getCategoryFromRecommendationType(rec.recommendationType);

        if ((repeatedTimeSlots[currentTime.hour]?.length ?? 0) > 5) {
          if (repeatedTimeSlots[currentTime.hour]!.any((e) => e.count > 5)) {
            continue;
          }
        }

        double intensity = (0.7 - rec.value).clamp(0.0, 1.0);

        if (intensity > 0) {
          String name;
          Duration duration;
          Duration restDuration;

          if (intensity > 0.6 && !intenseSportAdded) {
            name = 'Intense $category Activity';
            duration = Duration(hours: 1);
            restDuration = Duration(hours: 1);
            intenseSportAdded = true;
          } else if (intensity > 0.3) {
            name = 'Moderate $category Activity';
            duration = Duration(hours: 1);
            restDuration = Duration(minutes: 30);
          } else {
            name = 'Light $category Activity';
            duration = Duration(hours: 1);
            restDuration = Duration(minutes: 30);
          }

          newEvents.add(DayEvent(
            name: name,
            category: category,
            from: fullDate,
            to: fullDate.add(duration),
            healthModel: null,
            docId: idCounter.toString(),
          ));
          idCounter++;

          occupiedTimeRanges.add(DateTimeRange(start: fullDate, end: fullDate.add(duration)));

          DateTime restStartTime = fullDate.add(duration);
          newEvents.add(DayEvent(
            name: 'Rest',
            category: 'rest',
            from: restStartTime,
            to: restStartTime.add(restDuration),
            healthModel: null,
            docId: idCounter.toString(),
          ));
          idCounter++;

          occupiedTimeRanges.add(DateTimeRange(start: restStartTime, end: restStartTime.add(restDuration)));
          final time = restStartTime.add(restDuration);
          currentTime = TimeOfDay(
            hour: time.hour,
            minute: time.minute,
          );
          if (counter == 3) {
            break;
          }
          counter++;
        }
      }
    }

    //currentTime = TimeOfDay(hour: currentTime.hour + 1, minute: currentTime.minute);
    //}

    return newEvents;
  }

  String _getCategoryFromRecommendationType(RecommendationType type) {
    switch (type) {
      case RecommendationType.steps:
        return 'Walking';
      case RecommendationType.kcal:
        return 'Sport';
      case RecommendationType.sportActivity:
        return 'Sport';
      default:
        return 'Other';
    }
  }
}

// void main() {
//   List<DayEvent> events = [
//     DayEvent(
//       name: 'Football',
//       category: 'sport',
//       from: DateTime.now().subtract(const Duration(days: 2)),
//       to: DateTime.now().subtract(const Duration(days: 2, hours: -1)),
//       healthModel: const HealthModel(totalSteps: 5000, averageHeartRate: 120),
//       docId: '',
//     ),
//     DayEvent(
//       name: 'Meeting',
//       category: 'work',
//       from: DateTime.now().subtract(const Duration(days: 1)),
//       to: DateTime.now().subtract(const Duration(days: 1, hours: -1)),
//       healthModel: const HealthModel(totalSteps: 200, averageHeartRate: 80),
//       docId: '',
//     ),
//     DayEvent(
//       name: 'Writing diploma',
//       category: 'study',
//       from: DateTime.now().subtract(const Duration(days: 3)),
//       to: DateTime.now().subtract(const Duration(days: 3, hours: -1)),
//       healthModel: const HealthModel(totalSteps: 50, averageHeartRate: 70),
//       docId: '',
//     ),
//     DayEvent(
//       name: 'Reading',
//       category: 'rest',
//       from: DateTime.now().subtract(const Duration(days: 4)),
//       to: DateTime.now().subtract(const Duration(days: 4, hours: -1)),
//       healthModel: const HealthModel(totalSteps: 35, averageHeartRate: 68),
//       docId: '',
//     ),
//     DayEvent(
//       name: 'Fishing',
//       category: 'rest',
//       from: DateTime.now().subtract(const Duration(days: 5)),
//       to: DateTime.now().subtract(const Duration(days: 5, hours: -2)),
//       healthModel: const HealthModel(totalSteps: 30, averageHeartRate: 68),
//       docId: '',
//     ),
//   ];
//
//   Map<String, double> weights = {
//     'steps': 0.3,
//     'kcal': 0.3,
//     'heartRate': 0.2,
//     'sport': 0.2,
//   };
//
//   EventsAnalyzer recommendationSystem = EventsAnalyzer();
//   List<Recommendation> recommendations = recommendationSystem.recommendActivities(events, weights);
//
//   for (var recommendation in recommendations) {
//     print(recommendation);
//   }
// }
