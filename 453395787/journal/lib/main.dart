import 'package:flutter/material.dart';

import 'pages/journal_app.dart';
import 'utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemePreferences.init();
  runApp(const JournalApp());
}
