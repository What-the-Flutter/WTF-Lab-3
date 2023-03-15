import 'package:shared_preferences/shared_preferences.dart';

import 'themes.dart';

class ThemeSaver {
  static const keyName = 'theme';
  final ThemeKeys defaultTheme;
  final _prefs = SharedPreferences.getInstance();

  ThemeSaver({
    this.defaultTheme = ThemeKeys.light,
  });

  void save(ThemeKeys theme) async {
    final prefs = await _prefs;
    await prefs.setString(keyName, theme.name);
  }

  Future<ThemeKeys> read() async {
    final prefs = await _prefs;
    final name = prefs.getString(keyName);

    if (name == ThemeKeys.light.name) return ThemeKeys.light;
    if (name == ThemeKeys.dark.name) return ThemeKeys.dark;
    if (name == ThemeKeys.ugly.name) return ThemeKeys.ugly;

    return defaultTheme;
  }

  void deleteInfo() async {
    final prefs = await _prefs;
    await prefs.remove(keyName);
  }
}
