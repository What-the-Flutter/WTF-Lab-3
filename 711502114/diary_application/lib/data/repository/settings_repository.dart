import 'package:diary_application/data/provider/settings_provider_api.dart';
import 'package:diary_application/domain/repository/settings_repository_api.dart';

class SettingsRepository extends SettingsRepositoryApi {
  final SettingsProviderApi _provider;

  SettingsRepository({required SettingsProviderApi settingsProvider})
      : _provider = settingsProvider;

  @override
  Future<bool> get theme async => await _provider.theme;

  @override
  Future<bool> get isLocked async => await _provider.isLocked;

  @override
  Future<bool> get alignment async => await _provider.bubbleAlignment;

  @override
  Future<String> get backgroundImage async => _provider.backgroundImage;

  @override
  Future<String> get fontSize async => _provider.fontSize;

  @override
  Future<bool> get isCenter async => _provider.centerDate;

  @override
  void setTheme(bool isDark) {
    _provider.setTheme(isDark);
  }

  @override
  void setIsLocked(bool value) {
    _provider.setIsLocked(value);
  }

  @override
  void setBackgroundImage(String path) {
    _provider.setBackgroundImage(path);
  }

  @override
  void setFontSize(String size) {
    _provider.setFontSize(size);
  }

  @override
  void setBubbleAlignment(bool alignment) {
    _provider.setBubbleAlignment(alignment);
  }

  @override
  void setCenterDate(bool isCenter) {
    _provider.setCenterDate(isCenter);
  }

  @override
  void setDefault() {
    _provider.setDefault();
  }
}
