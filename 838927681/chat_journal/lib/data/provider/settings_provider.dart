import 'package:shared_preferences/shared_preferences.dart';

import '../repository/api_provider/api_settings_provider.dart';

abstract class SettingsKeys {
  static final isLocked = 'isLocked';
  static final isLight = 'isLight';
  static final centerDate = 'centerDate';
  static final bubbleAlignment = 'bubbleAlignment';
  static final backgroundImage = 'backgroundImage';
  static final fontSize = 'fontSize';
}

class SettingsProvider extends ApiSettingsProvider {
  @override
  Future<bool> get theme async {
    final prefs = await SharedPreferences.getInstance();
    final isLight = prefs.getBool(SettingsKeys.isLight) ?? true;
    return isLight;
  }

  @override
  Future<void> setTheme(bool isLight) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SettingsKeys.isLight, isLight);
  }

  @override
  Future<bool> get isLocked async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SettingsKeys.isLocked) ?? false;
  }

  @override
  Future<void> setIsLocked(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SettingsKeys.isLight, value);
  }

  @override
  Future<String> get backgroundImage async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SettingsKeys.backgroundImage) ?? '';
  }

  @override
  Future<bool> get bubbleAlignment async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SettingsKeys.bubbleAlignment) ?? false;
  }

  @override
  Future<bool> get centerDate async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SettingsKeys.centerDate) ?? false;
  }

  @override
  Future<int> get fontSize async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SettingsKeys.fontSize) ?? 0;
  }

  @override
  void setBackgroundImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SettingsKeys.backgroundImage, path);
  }

  @override
  void setBubbleAlignment(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SettingsKeys.bubbleAlignment, value);
  }

  @override
  void setCenterDate(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SettingsKeys.centerDate, value);
  }

  @override
  void setFontSize(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(SettingsKeys.fontSize, value);
  }

  @override
  void setDefault() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SettingsKeys.isLocked, false);
    prefs.setBool(SettingsKeys.isLight, true);
    prefs.setString(SettingsKeys.backgroundImage, '');
    prefs.setBool(SettingsKeys.bubbleAlignment, false);
    prefs.setBool(SettingsKeys.centerDate, false);
    prefs.setInt(SettingsKeys.fontSize, 0);
  }
}
