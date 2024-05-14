// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAXg3Cq0ueIDSZpSTKVQ1Nn62AcJCYgnIQ',
    appId: '1:438028767472:web:3a7a7a20d7ac54bfc33235',
    messagingSenderId: '438028767472',
    projectId: 'day-planner-ba42a',
    authDomain: 'day-planner-ba42a.firebaseapp.com',
    storageBucket: 'day-planner-ba42a.appspot.com',
    measurementId: 'G-H5Z7H2ZPF0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMrCA6iCaoS5wzriyXukv2t_WmoFCid4o',
    appId: '1:438028767472:android:726dc474239b991fc33235',
    messagingSenderId: '438028767472',
    projectId: 'day-planner-ba42a',
    storageBucket: 'day-planner-ba42a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCk1eM27jXRVl8EGEkfO804V11WkZ-XYJU',
    appId: '1:438028767472:ios:5747c785cb7987e2c33235',
    messagingSenderId: '438028767472',
    projectId: 'day-planner-ba42a',
    storageBucket: 'day-planner-ba42a.appspot.com',
    iosBundleId: 'com.example.dayPlanner',
  );
}
