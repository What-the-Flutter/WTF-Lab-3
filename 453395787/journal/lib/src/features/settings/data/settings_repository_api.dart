enum FontSize {
  small(scaleFactor: 0.8),
  medium(scaleFactor: 1),
  large(scaleFactor: 1.2);

  const FontSize({
    required this.scaleFactor,
  });

  final double scaleFactor;
}

abstract class SettingsRepositoryApi {
  FontSize get fontSize;
  Future<void> setFontSize(FontSize fontSize);
}
