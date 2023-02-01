enum FontScaleFactor {
  small(scaleFactor: 0.8),
  medium(scaleFactor: 1),
  large(scaleFactor: 1.2);

  const FontScaleFactor({
    required this.scaleFactor,
  });

  final double scaleFactor;
}
