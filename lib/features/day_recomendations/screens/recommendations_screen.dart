import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_bloc.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_event.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_state.dart';
import 'package:day_planner/features/day_recomendations/models/recommendation.dart';
import 'package:day_planner/features/main_page/widgets/schedule_list.dart';
import 'package:day_planner/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  @override
  void initState() {
    final thresholds = context.read<ProfileBloc>().state.userProfile!.healthThresholds;
    final from = getOnlyDate(DateTime.now().subtract(const Duration(days: 8)));
    final to = getOnlyDate(DateTime.now().subtract(const Duration(days: 1)));
    context.read<DayRecommendationsBloc>().add(FetchEventsForRange(from, to, thresholds));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
      ),
      body: BlocConsumer<DayRecommendationsBloc, DayRecommendationsState>(
        listener: _listener,
        builder: (context, state) {
          final recommendations = state.recommendations;
          return Column(
            children: [
              if (state.recommendationStatus.isLoading)
                Center(child: CircularProgressIndicator.adaptive())
              else if (state.recommendationStatus.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.check,
                        color: Colors.greenAccent,
                      ),
                      title: Text(
                        'Your indicators are in good level. Keep going',
                        style: context.textStyle(TextScale.titleMedium),
                      ),
                    ),
                  ),
                )
              else
                ...recommendations.map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        r.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                      leading: _getLeading(r),
                      tileColor: r.isPositive ? Colors.greenAccent : Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              if (state.recommendationStatus.isSuccess)
                FilledButton(
                  onPressed: () {
                    final dayEvents = [...context.read<DayPlannerBloc>().state.dayEvents];
                    context.read<DayRecommendationsBloc>().add(CreateActivities(dayEvents));
                  },
                  child: const Text('Build day plan'),
                ),
            ],
          );
        },
      ),
    );
  }

  void _listener(BuildContext context, DayRecommendationsState state) {
    if (state.generatedEventsStatus.isGenerating) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Generated events'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ScheduleManageEventView(
                  dayEvents: state.generatedDays,
                  day: state.day,
                  isGenerated: true,
                ),
              ),
            );
          },
        ),
      );
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       content: ScheduleManageEventView(
      //         dayEvents: state.generatedDays,
      //         day: state.day,
      //         isGenerated: true,
      //       ),
      //     );
      //   },
      // );
    }
  }

  Widget _getLeading(Recommendation recommendation) {
    if (recommendation.recommendationType.isSteps && !recommendation.isPositive) {
      return Icon(
        Icons.do_not_step_outlined,
        color: Theme.of(context).colorScheme.onError,
      );
    }
    if (recommendation.recommendationType.isKcal) {
      return Icon(
        Icons.local_fire_department,
        color: Theme.of(context).colorScheme.onError,
      );
    }
    if (recommendation.recommendationType.isSportActivity) {
      return Icon(
        Icons.sports_basketball_outlined,
        color: Theme.of(context).colorScheme.onError,
      );
    }
    return SizedBox();
  }
}
