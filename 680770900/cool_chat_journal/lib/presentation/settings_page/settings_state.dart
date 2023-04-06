part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final ThemeType themeType;
  final FontSizeType fontSizeType;
  final BubbleAlignmentType bubbleAlignmentType;
  final Uint8List? backgroundImage;

  const SettingsState({
    this.themeType = ThemeType.light,
    this.fontSizeType = FontSizeType.medium,
    this.bubbleAlignmentType = BubbleAlignmentType.left,
    this.backgroundImage,
  });

  SettingsState copyWith({
    ThemeType? themeType,
    FontSizeType? fontSizeType,
    BubbleAlignmentType? bubbleAlignmentType,
    NullWrapper<Uint8List?>? backgroundImage,
  }) =>
      SettingsState(
        themeType: themeType ?? this.themeType,
        fontSizeType: fontSizeType ?? this.fontSizeType,
        bubbleAlignmentType: bubbleAlignmentType ?? this.bubbleAlignmentType,
        backgroundImage: backgroundImage != null
            ? backgroundImage.value
            : this.backgroundImage,
      );

  @override
  List<Object?> get props => [
        themeType,
        fontSizeType,
        bubbleAlignmentType,
        backgroundImage,
      ];
}
