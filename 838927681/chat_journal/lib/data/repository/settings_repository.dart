import '../../domain/repositories/api_settings_repository.dart';
import 'api_provider/api_settings_provider.dart';

class SettingsRepository extends ApiSettingsRepository {
  final ApiSettingsProvider settingsProvider;

  SettingsRepository({required this.settingsProvider});

  @override
  Future<bool> get theme async => await settingsProvider.theme;

  @override
  void setTheme(bool isLight) {
    settingsProvider.setTheme(isLight);
  }

  @override
  Future<bool> get isLocked async => await settingsProvider.isLocked;

  @override
  void setIsLocked(bool value) {
    settingsProvider.setIsLocked(value);
  }
}
