class SettingsState {
  final int fontSize;
  final bool isRightBubbleAlignment;
  final bool isCenterDateBubble;
  final String? backgroundImage;

  SettingsState({
    fontSize,
    isRightBubbleAlignment,
    isCenterDateBubble,
    this.backgroundImage,
  })  : fontSize = fontSize ?? 16,
        isRightBubbleAlignment = isRightBubbleAlignment ?? false,
        isCenterDateBubble = isCenterDateBubble ?? false;

  SettingsState copyWith({
    int? fontSize,
    bool? isRightBubbleAlignment,
    bool? isCenterDateBubble,
    String? backgroundImage,
  }) {
    return SettingsState(
      fontSize: fontSize ?? this.fontSize,
      isRightBubbleAlignment:
          isRightBubbleAlignment ?? this.isRightBubbleAlignment,
      isCenterDateBubble: isCenterDateBubble ?? this.isCenterDateBubble,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }
}
