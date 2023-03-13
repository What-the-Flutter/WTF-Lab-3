import 'package:shared_preferences/shared_preferences.dart';

import 'settings_provider_api.dart';

class SettingsProvider extends SettingsProviderApi {
  static final themeKey = 'isDark';
  static final lockKey = 'isLocked';

  @override
  Future<bool> get theme async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(themeKey) ?? true;
    return isDark;
  }

  @override
  Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, isDark);
  }

  @override
  Future<bool> get isLocked async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(lockKey) ?? false;
  }

  @override
  Future<void> setIsLocked(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(lockKey, value);
  }
}
