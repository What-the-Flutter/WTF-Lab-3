import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider {
  Future<void> saveTheme(bool isLight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_light', isLight);
  }

  Future<void> saveFontSize(int fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('font_size', fontSize);
  }

  Future<void> saveBubbleAlignment(bool isRightToLeft) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_right_to_left', isRightToLeft);
  }

  Future<void> saveDateAlignment(bool isCenterDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_center_date', isCenterDate);
  }

  Future<void> saveDefaultPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_light', true);
    await prefs.setInt('font_size', 0);
    await prefs.setBool('is_right_to_left', false);
    await prefs.setBool('is_center_date', false);
  }

  Future<bool?> get theme async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool('is_light');
  }

  Future<int?> get fontSize async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getInt('font_size');
  }

  Future<bool?> get bubbleAlignment async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool('is_right_to_left');
  }

  Future<bool?> get dateAlignment async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool('is_center_date');
  }
}
