import 'package:flutter/material.dart';

import 'basic/themes/preferences.dart';
import 'ui/diary_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemePreferences.init();
  runApp(const DiaryApp());
}
