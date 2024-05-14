import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:day_planner/common/router.dart';
import 'package:day_planner/features/posts/services/services.dart';
import 'package:go_router/go_router.dart';

import '../../features/theme/bloc/theme_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                FilledButton(
                  onPressed: () {
                    context.go(pagesRoute);
                  },
                  child: const Text('Go to List Of Pages'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    context.read<ThemeBloc>().switchTheme();
                  },
                  child: const Text('Switch Theme'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    context.go(postsPath);
                  },
                  child: const Text('Posts'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    context.go(openSourceLicensesPageRoute);
                  },
                  child: const Text('Open source licenses'),
                ),
                const SizedBox(height: 8),
                const Text('Web-socket:'),
                // FilledButton(
                //   onPressed: () {
                //     context.read<WebSocketCubit>().connect();
                //   },
                //   child: const Text('Connect to web-socket'),
                // ),
                // FilledButton(
                //   onPressed: () {
                //     context.read<WebSocketCubit>().sendMessage(message: 'hi!');
                //   },
                //   child: const Text('Send message'),
                // ),
                // FilledButton(
                //   onPressed: () {
                //     context.read<WebSocketCubit>().closeConnection();
                //   },
                //   child: const Text('Close connection'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
