import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/health/models/health_model.dart';

class ActivityRecommendation {
  final List<DayEvent> events;
  final Map<String, double> weights;

  ActivityRecommendation(this.events, this.weights);

  // Анализ данных за неделю и определение, каких активностей не хватает
  Map<String, dynamic> analyzeUserActivities() {
    int totalSteps = 0;
    int totalHeartRate = 0;
    int activityCount = 0;

    Map<String, int> categoryCount = {};

    // Период для анализа (например, прошлая неделя)
    DateTime now = DateTime.now();
    DateTime weekAgo = now.subtract(const Duration(days: 7));

    for (var event in events) {
      if (event.from.isAfter(weekAgo) && event.to.isBefore(now)) {
        if (event.healthModel != null) {
          totalSteps += event.healthModel?.totalSteps ?? 0;
          totalHeartRate += event.healthModel?.averageHeartRate ?? 0;
          activityCount++;
        }
        if (!categoryCount.containsKey(event.category)) {
          categoryCount[event.category] = 0;
        }
        categoryCount[event.category] = categoryCount[event.category]! + 1;
      }
    }

    // Средние значения
    int averageSteps = activityCount > 0 ? totalSteps ~/ activityCount : 0;
    int averageHeartRate = activityCount > 0 ? totalHeartRate ~/ activityCount : 0;

    return {
      'averageSteps': averageSteps,
      'averageHeartRate': averageHeartRate,
      'categoryCount': categoryCount,
    };
  }

  // Нормализация данных
  Map<String, double> normalize(Map<String, dynamic> analysis, Map<String, int> thresholds) {
    double normalizeValue(int value, int min, int max) {
      return max == min ? 0 : (value - min) / (max - min);
    }

    return {
      'steps': normalizeValue(analysis['averageSteps'], 0, thresholds['steps']!),
      'heartRate': normalizeValue(analysis['averageHeartRate'], 0, thresholds['heartRate']!),
      'sport': normalizeValue(analysis['categoryCount']['sport'] ?? 0, 0, thresholds['sport']!),
      // Добавьте другие категории по мере необходимости
    };
  }

  // Агрегация оценок
  double aggregateScores(Map<String, double> normalizedValues) {
    double score = 0.0;
    normalizedValues.forEach((key, value) {
      score += value * weights[key]!;
    });
    return score;
  }

  // Предложение активностей
  List<String> recommendActivities() {
    Map<String, dynamic> analysis = analyzeUserActivities();

    // Пример пороговых значений для нормализации
    Map<String, int> thresholds = {
      'steps': 7000,
      'heartRate': 150,
      'sport': 5,
      // Добавьте другие категории по мере необходимости
    };

    Map<String, double> normalizedValues = normalize(analysis, thresholds);
    double score = aggregateScores(normalizedValues);

    List<String> recommendations = [];

    // Пример порога для предложений
    if (normalizedValues['steps']! < 0.7) {
      recommendations.add('Пора больше ходить! Попробуйте добавить активности из категории "спорт".');
    }

    if (normalizedValues['sport']! < 0.7) {
      recommendations.add('Вы делали мало спортивных мероприятий. Добавьте больше активностей из категории "спорт".');
    }

    // Добавьте другие условия для рекомендаций

    return recommendations;
  }
}

void main() {
  List<DayEvent> events = [
    DayEvent(
      name: 'Football',
      category: 'sport',
      from: DateTime.now().subtract(Duration(days: 2)),
      to: DateTime.now().subtract(Duration(days: 2, hours: -1)),
      healthModel: HealthModel(totalSteps: 5000, averageHeartRate: 120),
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
    'steps': 0.4,
    'heartRate': 0.3,
    'sport': 0.3,
    // Добавьте другие категории и их веса по мере необходимости
  };

  ActivityRecommendation recommendationSystem = ActivityRecommendation(events, weights);
  List<String> recommendations = recommendationSystem.recommendActivities();

  for (var recommendation in recommendations) {
    print(recommendation);
  }
}
