import 'package:day_planner/common/services/theme_box.dart';
import 'package:day_planner/features/auth/bloc/auth_bloc.dart';
import 'package:day_planner/features/auth/repositories/auth_repository.dart';
import 'package:day_planner/features/health/bloc/health_bloc.dart';
import 'package:day_planner/features/health/services/health.dart';
import 'package:day_planner/features/posts/posts.dart';
import 'package:day_planner/features/posts/services/posts_api_service.dart';
import 'package:day_planner/features/theme/bloc/theme_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../network/api_client.dart';

class GlobalBlocProvider extends StatelessWidget {
  const GlobalBlocProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Add here your BLoC/Cubits you are about to use through multiple screens
        BlocProvider(
          create: (context) => PostBloc(
            postsRepository: PostsRepositoryImpl(
              postsApiService: PostsApiServiceImpl(ApiClientImpl(dio: Dio())),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(Hive.box(ThemeBox.name))..add(const InitTheme()),
        ),
        BlocProvider(create: (context) => AuthBloc(context.read<AuthRepository>())),
        BlocProvider(create: (context) => HealthBloc(HealthService())),
        // BlocProvider(
        //   create: (context) => WebSocketCubit(webSocketService: InjectorModule.locator()),
        // ),
      ],
      child: child,
    );
  }
}
