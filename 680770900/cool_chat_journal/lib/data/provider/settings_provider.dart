import 'package:shared_preferences/shared_preferences.dart';

import '../models/theme.dart';

class SettingsProvider {
  static const themeName = 'theme';
  final _prefs = SharedPreferences.getInstance();

  Future<void> save(ThemeKey theme) async {
    final prefs = await _prefs;
    await prefs.setString(themeName, theme.name);
  }

  Future<ThemeKey> read() async {
    final prefs = await _prefs;
    final name = prefs.getString(themeName);

    if (name == ThemeKey.dark.name) return ThemeKey.dark;

    return ThemeKey.light;
  }
}
