import 'package:json_annotation/json_annotation.dart';

import '../json_kit.dart';

part 'theme_info.g.dart';

@JsonSerializable()
class ThemeInfo {
  static const List<String> fields = [
    'theme_type',
    'font_size',
    'bubble_alignment',
  ];

  final String themeType;
  final String fontSize;
  final String bubbleAlignment;

  const ThemeInfo({
    required this.themeType,
    required this.fontSize,
    required this.bubbleAlignment,
  });

  factory ThemeInfo.fromJson(JsonMap json) => _$ThemeInfoFromJson(json);

  JsonMap toJson() => _$ThemeInfoToJson(this);

  ThemeInfo copyWith({
    String? themeType,
    String? fontSize,
    String? bubbleAlignment,
  }) =>
      ThemeInfo(
        themeType: themeType ?? this.themeType,
        fontSize: fontSize ?? this.fontSize,
        bubbleAlignment: bubbleAlignment ?? this.bubbleAlignment,
      );
}
