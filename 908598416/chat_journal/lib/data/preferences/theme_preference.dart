import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const _themeKey = 'theme_key';

  void setTheme(bool value) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool(_themeKey, value);
  }

  Future<bool> getTheme() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(_themeKey) ?? false;
  }
}