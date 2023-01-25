import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static final _instance = ThemePreferences._();

  static late SharedPreferences _preference;
  final _isDarkModeKey = 'isDarkMode';

  ThemePreferences._();

  factory ThemePreferences.get() => _instance;

  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  bool get isDarkMode {
    final value = _preference.getBool(_isDarkModeKey);
    if (value == null) {
      isDarkMode = false;
      return false;
    } else {
      return value;
    }
  }

  set isDarkMode(bool value) {
    _preference.setBool(_isDarkModeKey, value);
  }
}
