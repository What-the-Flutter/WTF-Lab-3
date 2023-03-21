enum ThemeKey { light, dark }

extension ThemeKeyX on ThemeKey {
  bool get isLight => this == ThemeKey.light;
  bool get isDark => this == ThemeKey.dark;
}