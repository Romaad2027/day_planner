import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:day_planner/firebase_options.dart' as dev_options;
import 'package:day_planner/firebase_options.dart' as prod_options;

const _flavorKey = 'FLAVOR';

enum AppFlavor {
  dev,
  prod;

  bool get isDev => this == AppFlavor.dev;
  bool get isProd => this == AppFlavor.prod;

  static Future<AppFlavor> fromAppFlavor() async {
    const flavor = kIsWeb ? String.fromEnvironment(_flavorKey) : appFlavor;
    return _fromString(flavor);
  }

  static AppFlavor _fromString(String? flavor) {
    switch (flavor) {
      case 'dev':
        return AppFlavor.dev;
      case 'prod':
        return AppFlavor.prod;
      default:
        throw Exception('Proper flavor must be provided!');
    }
  }

  FirebaseOptions get getFirebaseOptions {
    switch (this) {
      case AppFlavor.dev:
        return dev_options.DefaultFirebaseOptions.currentPlatform;
      case AppFlavor.prod:
        return prod_options.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
