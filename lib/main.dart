import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'application.dart';
import 'common/services/services.dart';
import 'common/widgets/widgets.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemeBox().initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LoggerBootstrapper().setupLogger();

  runApp(
    const RepositoriesHolder(
      child: GlobalBlocProvider(
        child: Application(),
      ),
    ),
  );
}
