import '../../domain/repository/settings_repository_api.dart';
import '../provider/settings_provider_api.dart';

class SettingsRepository extends SettingsRepositoryApi {
  final SettingsProviderApi _provider;

  SettingsRepository({required SettingsProviderApi settingsProvider})
      : _provider = settingsProvider;

  @override
  Future<bool> get theme async => await _provider.theme;

  @override
  void setTheme(bool isDark) {
    _provider.setTheme(isDark);
  }

  @override
  Future<bool> get isLocked async => await _provider.isLocked;

  @override
  void setIsLocked(bool value) {
    _provider.setIsLocked(value);
  }
}
