abstract class SettingsRepositoryApi {
  Future<bool> get theme;

  Future<bool> get isLocked;

  void setTheme(bool isDark);

  void setIsLocked(bool value);
}
