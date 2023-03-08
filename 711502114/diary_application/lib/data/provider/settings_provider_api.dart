abstract class SettingsProviderApi {
  Future<void> setTheme(bool isDark);

  Future<void> setIsLocked(bool value);

  Future<bool> get theme;

  Future<bool> get isLocked;
}
