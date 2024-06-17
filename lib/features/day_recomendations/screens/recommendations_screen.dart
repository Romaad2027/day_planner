import 'package:day_planner/common/utils/app_utils.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_bloc.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_event.dart';
import 'package:day_planner/features/day_recomendations/bloc/day_recomendations_state.dart';
import 'package:day_planner/features/main_page/widgets/schedule_list.dart';
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
    final from = getOnlyDate(DateTime.now().subtract(const Duration(days: 8)));
    final to = getOnlyDate(DateTime.now().subtract(const Duration(days: 1)));
    context.read<DayRecommendationsBloc>().add(FetchEventsForRange(from, to));
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
              ...recommendations.map(
                (r) => ListTile(
                  title: Text(r.toString()),
                ),
              ),
              const SizedBox(height: 16),
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ScheduleManageEventView(
              dayEvents: state.generatedDays,
              day: state.day,
            ),
          );
        },
      );
    }
  }
}
