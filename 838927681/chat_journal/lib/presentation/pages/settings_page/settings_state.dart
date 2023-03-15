import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isLightTheme;
  final bool isLocked;
  final bool bubbleAlignment;
  final String backgroundImage;
  final bool centerDate;
  final int fontSize;

  const SettingsState({
    required this.isLightTheme,
    required this.isLocked,
    required this.backgroundImage,
    required this.bubbleAlignment,
    required this.centerDate,
    required this.fontSize,
  });

  SettingsState copyWith({
    bool? isLightTheme,
    bool? isLocked,
    bool? bubbleAlignment,
    String? backgroundImage,
    bool? centerDate,
    int? fontSize,
  }) {
    return SettingsState(
      isLightTheme: isLightTheme ?? this.isLightTheme,
      isLocked: isLocked ?? this.isLocked,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      bubbleAlignment: bubbleAlignment ?? this.bubbleAlignment,
      centerDate: centerDate ?? this.centerDate,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [
        isLightTheme,
        isLocked,
        backgroundImage,
        bubbleAlignment,
        centerDate,
        fontSize,
      ];
}
