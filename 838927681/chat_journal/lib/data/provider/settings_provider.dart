import 'package:shared_preferences/shared_preferences.dart';

import '../repository/api_provider/api_settings_provider.dart';

class SettingsProvider extends ApiSettingsProvider {
  @override
  Future<bool> get theme async {
    final prefs = await SharedPreferences.getInstance();
    final isLight = prefs.getBool('isLight') ?? true;
    return isLight;
  }

  @override
  Future<void> setTheme(bool isLight) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLight', isLight);
  }

  @override
  Future<bool> get isLocked async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLocked') ?? false;
  }

  @override
  Future<void> setIsLocked(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLocked', value);
  }
}
