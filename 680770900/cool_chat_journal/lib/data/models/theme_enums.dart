enum ThemeType { light, dark }

enum FontSizeType { small, medium, large }

enum BubbleAlignmentType { left, right }

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
