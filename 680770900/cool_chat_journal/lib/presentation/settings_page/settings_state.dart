part of 'settings_cubit.dart';

enum ThemeType { light, dark }

enum FontSizeType { small, medium, large }

enum BubbleAlignmentType { left, right }

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
    _NullWrapper<Uint8List?>? backgroundImage,
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

class _Converter<T extends Enum> {
  final List<T> values;
  final T defaultValue;

  const _Converter({
    required this.values,
    required this.defaultValue,
  });

  T fromString(String value) =>
      values.firstWhereOrNull((e) => e.name == value) ?? defaultValue;
}

class _NullWrapper<T> {
  final T value;

  const _NullWrapper({required this.value});
}

extension BubbleAlignmentTypeX on BubbleAlignmentType {
  BubbleAlignmentType get next {
    switch (this) {
      case BubbleAlignmentType.left:
        return BubbleAlignmentType.right;
      case BubbleAlignmentType.right:
        return BubbleAlignmentType.left;
    }
  }

  bool get isLeft => this == BubbleAlignmentType.left;
  bool get isRight => this == BubbleAlignmentType.right;
}

extension ThemeTypeX on ThemeType {
  ThemeType get next {
    switch (this) {
      case ThemeType.light:
        return ThemeType.dark;
      case ThemeType.dark:
        return ThemeType.light;
    }
  }

  bool get isLight => this == ThemeType.light;
  bool get isDark => this == ThemeType.dark;
}
