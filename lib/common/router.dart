import 'package:day_planner/common/screens/open_source_licenses_screen.dart';
import 'package:day_planner/common/screens/splash_screen.dart';
import 'package:day_planner/features/auth/screens/auth_screen.dart';
import 'package:day_planner/features/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/screens.dart';
import 'widgets/widgets.dart';

/* * * * * * * * * * * *
*
* /home
* /pages
*     /pages/1
*     /pages/2
*     ...
*     /pages/test
*
* * * * * * * * * * * */
const String homeRoute = '/';
const String splashRoute = '/splash';
const String pagesRoute = '/pages';
const String postsRoute = '/posts';
const String pagesDynamicRoute = ':id';
const String firstPageRoute = '/pages/1';
const String openSourceLicensesPageRoute = '/open-source-licenses';
const String appUpdateRequiredRoute = '/app-update-required-route';

final goRouter = GoRouter(
  initialLocation: homeRoute,
  errorBuilder: (context, state) => ErrorScreen(state.error),
  routes: [
    GoRoute(
      path: homeRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const AuthScreen(),
      ),
    ),
    GoRoute(
      path: splashRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: postsRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const PostsScreen(),
      ),
      routes: <RouteBase>[
        GoRoute(
          path: pagesDynamicRoute,
          // builder: (BuildContext context, GoRouterState state) {
          //   return const PageWidget();
          // },
          pageBuilder: (context, state) => _TransitionPage(
            key: state.pageKey,
            child: const PageWidget(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: pagesRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const PagesListScreen(),
      ),
      routes: <RouteBase>[
        GoRoute(
          path: pagesDynamicRoute,
          // builder: (BuildContext context, GoRouterState state) {
          //   return const PageWidget();
          // },
          pageBuilder: (context, state) => _TransitionPage(
            key: state.pageKey,
            child: const PageWidget(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: openSourceLicensesPageRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const OpenSourceLicensesScreen(),
      ),
    ),
  ],
);

class _TransitionPage extends CustomTransitionPage<dynamic> {
  _TransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          // create your own or use an existing one
          // ScaleTransition(scale: animation, child: child),
        );
}
