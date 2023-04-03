import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _keyDefaultThemeMode = 'default_theme_mode';
  static const _keyFontSize = 'font_size';
  static const _keyBubbleAlignment = 'bubble_alignment';
  static const _keyDateBubble = 'date_bubble';
  static const _keyBackground = 'backgroundImage';

  Future<bool> loadThemePreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_keyDefaultThemeMode) ?? true;
  }

  Future<int> loadFontPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_keyFontSize) ?? 16;
  }

  Future<bool> loadBubbleAlignmentPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_keyBubbleAlignment) ?? false;
  }

  Future<bool> loadDateBubblePreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_keyDateBubble) ?? false;
  }

  Future<String?> loadBackgroundImage() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_keyBackground);
  }

  Future<void> updateTheme(bool isDefaultTheme) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_keyDefaultThemeMode, isDefaultTheme);
  }

  Future<void> updateFont(int fontSize) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_keyFontSize, fontSize);
  }

  Future<void> updateBubbleAlignment(bool isRightSide) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_keyBubbleAlignment, isRightSide);
  }

  Future<void> updateDateBubble(bool isCenterBubble) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_keyDateBubble, isCenterBubble);
  }

  Future<void> updateBackgroundImage(String? backgroundImage) async {
    final preferences = await SharedPreferences.getInstance();
    backgroundImage != null
        ? await preferences.setString(_keyBackground, backgroundImage)
        : preferences.remove(_keyBackground);
  }
}
