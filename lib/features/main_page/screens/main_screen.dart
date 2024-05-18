import 'package:day_planner/features/main_page/widgets/calendar.dart';
import 'package:day_planner/features/main_page/widgets/daily_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Calendar(),
              DailyList(),
            ],
          ),
        ),
      ),
    );
  }
}
