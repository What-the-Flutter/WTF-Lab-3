abstract class ApiSettingsProvider {
  Future<void> setTheme(bool isLight);

  Future<void> setIsLocked(bool value);

  Future<bool> get theme;

  Future<bool> get isLocked;
}
