import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_tag.freezed.dart';

part 'text_tag.g.dart';

@freezed
class TextTag with _$TextTag {
  const factory TextTag({
    required String id,
    required String text,
  }) = _TextTag;

  factory TextTag.fromJson(Map<String, dynamic> json) =>
      _$TextTagFromJson(json);
}
