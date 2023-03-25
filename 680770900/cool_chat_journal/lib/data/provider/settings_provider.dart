import 'package:shared_preferences/shared_preferences.dart';

import '../models/theme_info.dart';

class SettingsProvider {
  final _prefs = SharedPreferences.getInstance();

  Future<void> save(ThemeInfo themeInfo) async {
    final prefs = await _prefs;
    final json = themeInfo.toJson();

    for (final field in json.keys) {
      await prefs.setString(field, json[field] as String);
    }
  }

  Future<ThemeInfo> read({
    String? defaultValue = '',
  }) async {
    final prefs = await _prefs;
    var json = <String, dynamic>{};

    for (final field in ThemeInfo.fields) {
      json[field] = await prefs.getString(field) ?? defaultValue;
    }

    return ThemeInfo.fromJson(json);
  }
}
