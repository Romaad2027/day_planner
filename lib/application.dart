import 'package:day_planner/common/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/router.dart';
import 'features/theme/theme.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImages(context);
      precacheSvgs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.select((ThemeBloc bloc) => bloc.state);
    return MaterialApp.router(
      title: 'Day Planner',
      routerConfig: goRouter,
      darkTheme: MaterialTheme().dark(),
      theme: themeState.getThemeData(View.of(context).platformDispatcher.platformBrightness),
      themeMode: themeState.themeMode,
    );
  }
}
