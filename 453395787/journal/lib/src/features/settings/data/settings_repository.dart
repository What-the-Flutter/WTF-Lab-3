import 'package:shared_preferences/shared_preferences.dart';

import 'settings_repository_api.dart';

class SettingsRepository extends SettingsRepositoryApi {
  static final String _fontSizeKey = 'fontSizeKey';

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final fontSizeName = prefs.getString(_fontSizeKey);
    if (fontSizeName != null) {
      _fontSize = FontSize.values.byName(fontSizeName);
    }
  }

  static FontSize _fontSize = FontSize.medium;

  @override
  FontSize get fontSize => _fontSize;

  @override
  Future<void> setFontSize(FontSize fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_fontSizeKey, fontSize.name);
  }
}
