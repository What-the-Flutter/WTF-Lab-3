abstract class SettingsRepositoryApi {
  Future<bool> get theme;

  Future<bool> get isLocked;

  Future<String> get fontSize;

  Future<bool> get alignment;

  Future<bool> get isCenter;

  Future<String> get backgroundImage;

  void setTheme(bool isDark);

  void setIsLocked(bool value);

  void setFontSize(String size);

  void setBubbleAlignment(bool alignment);

  void setCenterDate(bool isCenter);

  void setBackgroundImage(String path);

  void setDefault();
}
