import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/typedefs.dart';

part 'tag.freezed.dart';

part 'tag.g.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({
    @Default('') Id id,
    @Default('') String text,
    required int colorCode,
  }) = _Tag;

  factory Tag.fromJson(Map<String, Object?> json) => _$TagFromJson(json);
}
