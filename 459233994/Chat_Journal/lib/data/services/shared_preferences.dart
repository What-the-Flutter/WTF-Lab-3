import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _keyDefaultMode = 'default_mode';

  Future<bool> loadPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_keyDefaultMode) ?? true;
  }

  void update(bool isDefaultTheme) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_keyDefaultMode, isDefaultTheme);
    print(preferences.getBool(_keyDefaultMode));
  }
}