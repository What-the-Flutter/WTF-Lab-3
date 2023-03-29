abstract class ApiSettingsProvider {
  const ApiSettingsProvider();
  Future<void> setTheme(bool isLight);

  Future<void> setIsLocked(bool value);

  void setBubbleAlignment(bool value);

  void setFontSize(int value);

  void setBackgroundImage(String path);

  void setCenterDate(bool value);

  void setDefault();

  Future<bool> get theme;

  Future<bool> get isLocked;

  Future<bool> get bubbleAlignment;

  Future<int> get fontSize;

  Future<bool> get centerDate;

  Future<String> get backgroundImage;
}
