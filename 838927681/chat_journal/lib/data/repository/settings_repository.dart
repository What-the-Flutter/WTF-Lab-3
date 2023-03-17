import '../../domain/repositories/api_settings_repository.dart';
import 'api_provider/api_settings_provider.dart';

class SettingsRepository extends ApiSettingsRepository {
  final ApiSettingsProvider _settingsProvider;

  SettingsRepository({required ApiSettingsProvider settingsProvider})
      : _settingsProvider = settingsProvider;

  @override
  Future<bool> get theme => _settingsProvider.theme;

  @override
  void setTheme(bool isLight) => _settingsProvider.setTheme(isLight);

  @override
  Future<bool> get isLocked => _settingsProvider.isLocked;

  @override
  void setIsLocked(bool value) => _settingsProvider.setIsLocked(value);

  @override
  Future<String> get backgroundImage => _settingsProvider.backgroundImage;

  @override
  Future<bool> get bubbleAlignment => _settingsProvider.bubbleAlignment;

  @override
  Future<bool> get centerDate => _settingsProvider.centerDate;

  @override
  Future<int> get fontSize => _settingsProvider.fontSize;

  @override
  void setBackgroundImage(String path) =>
      _settingsProvider.setBackgroundImage(path);

  @override
  void setBubbleAlignment(bool value) =>
      _settingsProvider.setBubbleAlignment(value);

  @override
  void setCenterDate(bool value) => _settingsProvider.setCenterDate(value);

  @override
  void setFontSize(int value) => _settingsProvider.setFontSize(value);

  @override
  void setDefault() => _settingsProvider.setDefault();
}
