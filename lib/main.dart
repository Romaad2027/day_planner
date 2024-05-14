import 'package:flutter/material.dart';

import 'application.dart';
import 'common/services/services.dart';
import 'common/widgets/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemeBox().initialize();

  runApp(
    const GlobalBlocProvider(
      child: RepositoriesHolder(
        child: Application(),
      ),
    ),
  );
}
