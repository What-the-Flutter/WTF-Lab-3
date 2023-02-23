abstract class ApiSettingsRepository {
  Future<bool> get theme;

  Future<bool> get isLocked;

  void setTheme(bool isLight);

  void setIsLocked(bool value);
}
