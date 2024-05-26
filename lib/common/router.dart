import 'package:day_planner/common/screens/splash_screen.dart';
import 'package:day_planner/features/auth/screens/auth_screen.dart';
import 'package:day_planner/features/auth/screens/phone_verification_screen.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/day_planner/screens/add_event_screen.dart';
import 'package:day_planner/features/day_planner/screens/view_event_screen.dart';
import 'package:day_planner/features/main_page/screens/main_screen.dart';
import 'package:day_planner/features/posts/posts.dart';
import 'package:day_planner/features/profile/screens/profile_screen.dart';
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
const String authRoute = '/auth';
const String phoneVerificationRoute = '/phone-verification';
const String mainRoute = '/main';
const String profileRoute = '/profile';
const String pagesRoute = '/pages';
const String postsRoute = '/posts';
const String addEventRoute = '/add-event';
const String viewEventRoute = '/view-add-event';
const String pagesDynamicRoute = ':id';
const String firstPageRoute = '/pages/1';
const String openSourceLicensesPageRoute = '/open-source-licenses';
const String appUpdateRequiredRoute = '/app-update-required-route';

final goRouter = GoRouter(
  initialLocation: splashRoute,
  errorBuilder: (context, state) => ErrorScreen(state.error),
  routes: [
    GoRoute(
      path: authRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const AuthScreen(),
      ),
    ),
    GoRoute(
      path: phoneVerificationRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const PhoneVerificationScreen(),
      ),
    ),
    GoRoute(
      path: homeRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: mainRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const MainScreen(),
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
      path: profileRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const ProfileScreen(),
      ),
    ),
    GoRoute(
      path: addEventRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const AddEventScreen(),
      ),
    ),
    GoRoute(
      path: viewEventRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: ViewEventScreen(dayEvent: (state.extra as Map<String, DayEvent>)['dayEvent']!),
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
