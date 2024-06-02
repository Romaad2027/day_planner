import 'package:day_planner/features/day_recomendations/models/recommendation_type.dart';

class Recommendation {
  final RecommendationType recommendationType;
  final bool isPositive;
  final double value;

  const Recommendation({
    required this.recommendationType,
    required this.isPositive,
    required this.value,
  });

  @override
  String toString() {
    String recommendationMessage;
    if (isPositive) {
      recommendationMessage = 'Your indicators are within the norm. Keep up the good work!';
    } else {
      if (value < 0.3) {
        recommendationMessage =
            'Your indicator is well below the norm. You need to pay more attention to this activity.';
      } else if (value < 0.5) {
        recommendationMessage = 'Your indicator is below the norm. Try to improve your results.';
      } else if (value < 0.7) {
        recommendationMessage = 'Your indicator is slightly below the norm. Try a little harder.';
      } else {
        recommendationMessage = 'Your indicator is at a good level. Keep up the good work!';
      }
    }
    return 'Recommendation: $recommendationType - $recommendationMessage';
  }
}
