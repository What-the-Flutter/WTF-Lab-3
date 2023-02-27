abstract class ApiThemeRepository {
  bool get isDarkMode;

  double get messageFontSize;

  double get messageBorderRadius;

  int get primaryColor;

  int get primaryItemColor;

  String get messageAlignment;

  bool get dateBubbleVisible;

  int get chatBackgroundColor;

  String get imagePath;

  Future<void> setColors(int primaryColor, int primaryItemColor);

  Future<void> setDarkMode(bool isDarkMode);

  Future<void> setMessageFontSize(double fontSize);

  Future<void> setMessageBorderRadius(double radius);

  Future<void> setMessageAlignment(String alignment);

  Future<void> setDateBubbleVisible(bool value);

  Future<void> setChatBackgroundColor(int color);

  Future<void> setImagePath(String path);
}
