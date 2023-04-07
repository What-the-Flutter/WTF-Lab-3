import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider {
  final _isLight = 'is_light';
  final _fontSize = 'font_size';
  final _isRightToLeft = 'is_right_to_left';
  final _isCenterDate = 'is_center_date';
  final _backgroundImage = 'background_image';
  final _useFingerPrint = 'use_fingerprint';

  Future<SharedPreferences> get sharedPreferencesInstance =>
      SharedPreferences.getInstance();

  Future<void> saveTheme(bool isLight) async {
    final prefs = await sharedPreferencesInstance;
    await prefs.setBool(_isLight, isLight);
  }

  Future<void> saveFontSize(int fontSize) async {
    final prefs = await sharedPreferencesInstance;
    await prefs.setInt(_fontSize, fontSize);
  }

  Future<void> saveBubbleAlignment(bool isRightToLeft) async {
    final prefs = await sharedPreferencesInstance;
    await prefs.setBool(_isRightToLeft, isRightToLeft);
  }

  Future<void> saveDateAlignment(bool isCenterDate) async {
    final prefs = await sharedPreferencesInstance;
    await prefs.setBool(_isCenterDate, isCenterDate);
  }

  Future<void> saveDefaultThemeAndFontPreferences() async {
    final prefs = await sharedPreferencesInstance;
    await prefs.setBool(_isLight, true);
    await prefs.setInt(_fontSize, 0);
  }

  Future<void> saveBackgroundImage(String path) async {
    final prefs = await sharedPreferencesInstance;
    await prefs.setString(_backgroundImage, path);
  }

  Future<void> saveUsingFingerprint(bool useFingerprint) async {
    final prefs = await sharedPreferencesInstance;
    await prefs.setBool(_useFingerPrint, useFingerprint);
  }

  Future<bool> get theme async {
    final prefs = await sharedPreferencesInstance;
    return await prefs.getBool(_isLight) ?? true;
  }

  Future<int> get fontSize async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getInt(_fontSize) ?? 0;
  }

  Future<bool> get bubbleAlignment async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(_isRightToLeft) ?? false;
  }

  Future<bool> get dateAlignment async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(_isCenterDate) ?? false;
  }

  Future<String> get backgroundImage async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString(_backgroundImage) ?? '';
  }

  Future<bool> get useFingerprint async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(_useFingerPrint) ?? false;
  }
}
