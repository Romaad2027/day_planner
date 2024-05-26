import 'package:day_planner/common/router.dart';
import 'package:day_planner/common/widgets/bottom_nav_bar.dart';
import 'package:day_planner/common/widgets/flushbar.dart';
import 'package:day_planner/features/auth/bloc/auth_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_bloc.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_event.dart';
import 'package:day_planner/features/day_planner/bloc/day_planner_state.dart';
import 'package:day_planner/features/health/bloc/health_bloc.dart';
import 'package:day_planner/features/main_page/screens/main_screen.dart';
import 'package:day_planner/features/profile/bloc/profile_bloc.dart';
import 'package:day_planner/features/profile/bloc/profile_event.dart';
import 'package:day_planner/features/profile/screens/profile_screen.dart';
import 'package:day_planner/features/tab_switcher/cubit/tab_switch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HealthBloc>().add(const InitHealth());
    context.read<ProfileBloc>().add(const ListenToUser());
    context.read<DayPlannerBloc>().add(ListenToDay(DateTime.now()));
    context.read<DayPlannerBloc>().add(const ListenToCurrentDay());
    context.read<DayPlannerBloc>().add(const StartTimer());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: _authListener,
        ),
        BlocListener<HealthBloc, HealthState>(
          listener: _healthListener,
        ),
        BlocListener<DayPlannerBloc, DayPlannerState>(
          listenWhen: (prev, curr) => prev.currentDayStatus != curr.currentDayStatus,
          listener: _dayPlannerListener,
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<TabsSwitchCubit, TabsSwitchState>(
          builder: (context, state) {
            switch (state.tab) {
              case TabScreen.main:
                return const MainScreen();
              case TabScreen.profile:
                return const ProfileScreen();
            }
          },
        ),
        bottomNavigationBar: CommonBottomNavBar(),
      ),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state.authStatus.isLoggedOut) {
      context.go(authRoute);
    }
  }

  void _healthListener(BuildContext context, HealthState state) {
    if (state.healthInitStatus.isError) {
      showSnackBar(context,
          status: FlushbarStatus.error, message: 'Something went wrong while Health data integration');
    } else if (state.healthInitStatus.isDeclined) {
      showSnackBar(
        context,
        status: FlushbarStatus.error,
        message: 'Your Health data permission was denied. Go to settings to allow it.',
      );
    }
  }

  void _dayPlannerListener(BuildContext context, DayPlannerState state) {
    if (state.currentDayStatus.isSuccess && state.currentDayEvents.isNotEmpty) {
      context.read<DayPlannerBloc>().add(const FetchHealthData());
    }
  }
}
