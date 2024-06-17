import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_planner/features/auth/repositories/auth_repository.dart';
import 'package:day_planner/features/auth/services/auth_service.dart';
import 'package:day_planner/features/day_planner/repositories/events_repository.dart';
import 'package:day_planner/features/day_recomendations/repository/recommendations_repository.dart';
import 'package:day_planner/features/health/services/health.dart';
import 'package:day_planner/features/profile/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoriesHolder extends StatelessWidget {
  final Widget child;

  const RepositoriesHolder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(AuthService()),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryImpl(FirebaseFirestore.instance),
        ),
        RepositoryProvider<EventsRepository>(
          create: (context) => EventsRepositoryImpl(FirebaseFirestore.instance),
        ),
        RepositoryProvider<HealthService>(
          create: (context) => HealthService(),
        ),
        RepositoryProvider<RecommendationsRepository>(
          create: (context) => RecommendationsRepositoryImpl(),
        ),
      ],
      child: child,
    );
  }
}
