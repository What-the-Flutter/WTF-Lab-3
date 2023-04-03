import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/provider/settings_provider.dart';
import 'domain/services/authentication.dart';
import 'firebase_options.dart';
import 'presentation/pages/init_blocs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'chat journal',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    InitBlocs(
      user: await Authentication().getOrCreateUser(),
      settingsProvider: const SettingsProvider(),
    ),
  );
}
