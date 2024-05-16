import 'package:day_planner/common/router.dart';
import 'package:day_planner/common/widgets/flushbar.dart';
import 'package:day_planner/features/auth/bloc/auth_bloc.dart';
import 'package:day_planner/features/health/bloc/health_bloc.dart';
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
      ],
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  FilledButton(
                    onPressed: () => context.read<AuthBloc>().add(const LogOut()),
                    child: const Text('Log out'),
                  )
                ],
              ),
            ),
          ],
        ),
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
}
