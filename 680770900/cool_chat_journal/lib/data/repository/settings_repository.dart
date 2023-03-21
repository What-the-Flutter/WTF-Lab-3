import '../models/models.dart';
import '../provider/settings_provider.dart';

class SettingsRepository {
  final _settingsProvider = SettingsProvider();

  Future<void> saveTheme(ThemeKey themeKey) async =>
      await _settingsProvider.save(themeKey);

  Future<ThemeKey> updateTheme() async => await _settingsProvider.read();
}
