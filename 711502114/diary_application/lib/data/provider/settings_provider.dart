import 'package:shared_preferences/shared_preferences.dart';

import 'settings_provider_api.dart';

class SettingsProvider extends SettingsProviderApi {
  static final themeKey = 'isDark';
  static final lockKey = 'isLocked';
  static final fontSizeKey = 'font size';
  static final bubbleAlignmentKey = 'bubble alignment';
  static final centerDateKey = 'center date';
  static final backgroundImageKey = 'background image';

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

  @override
  Future<String> get backgroundImage async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(backgroundImageKey) ?? '';
  }

  @override
  Future<void> setBackgroundImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(backgroundImageKey, path);
  }

  @override
  Future<String> get fontSize async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(fontSizeKey) ?? 'default';
  }

  @override
  Future<void> setFontSize(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(fontSizeKey, value);
  }

  @override
  Future<bool> get bubbleAlignment async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(bubbleAlignmentKey) ?? false;
  }

  @override
  Future<void> setBubbleAlignment(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(bubbleAlignmentKey, value);
  }

  @override
  Future<bool> get centerDate async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(centerDateKey) ?? false;
  }

  @override
  Future<void> setCenterDate(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(centerDateKey, value);
  }

  @override
  void setDefault() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, true);
    prefs.setBool(lockKey, false);
    prefs.setInt(fontSizeKey, 0);
    prefs.setString(backgroundImageKey, '');
    prefs.setBool(bubbleAlignmentKey, false);
    prefs.setBool(centerDateKey, false);
  }
}
