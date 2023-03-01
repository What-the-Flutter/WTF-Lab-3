import 'package:shared_preferences/shared_preferences.dart';

import '../repository/api_provider/api_settings_provider.dart';

class Keys {
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
    final isLight = prefs.getBool(Keys.isLight) ?? true;
    return isLight;
  }

  @override
  Future<void> setTheme(bool isLight) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Keys.isLight, isLight);
  }

  @override
  Future<bool> get isLocked async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Keys.isLocked) ?? false;
  }

  @override
  Future<void> setIsLocked(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Keys.isLight, value);
  }

  @override
  Future<String> get backgroundImage async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Keys.backgroundImage) ?? '';
  }

  @override
  Future<bool> get bubbleAlignment async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Keys.bubbleAlignment) ?? false;
  }

  @override
  Future<bool> get centerDate async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Keys.centerDate) ?? false;
  }

  @override
  Future<int> get fontSize async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Keys.fontSize) ?? 0;
  }

  @override
  void setBackgroundImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Keys.backgroundImage, path);
  }

  @override
  void setBubbleAlignment(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Keys.bubbleAlignment, value);
  }

  @override
  void setCenterDate(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Keys.centerDate, value);
  }

  @override
  void setFontSize(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(Keys.fontSize, value);
  }

  @override
  void setDefault() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Keys.isLocked, false);
    prefs.setBool(Keys.isLight, true);
    prefs.setString(Keys.backgroundImage, '');
    prefs.setBool(Keys.bubbleAlignment, false);
    prefs.setBool(Keys.centerDate, false);
    prefs.setInt(Keys.fontSize, 0);
  }
}
