abstract class ApiThemeRepository {
  bool get isDarkMode;

  double get messageFontSize;

  int get primaryColor;

  int get primaryItemColor;

  Future<void> setColors(int primaryColor, int primaryItemColor);

  Future<void> setDarkMode(bool isDarkMode);

  Future<void> setMessageFontSize(double fontSize);
}
