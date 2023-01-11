import 'dart:ui';

abstract class ThemeRepositoryApi {
  Future<Color> getColor();

  Future<bool> getDarkMode();

  Future<void> setColor(Color color);

  Future<void> setDarkMode(bool isDarkMode);
}
