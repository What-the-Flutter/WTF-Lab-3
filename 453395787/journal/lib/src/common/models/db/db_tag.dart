import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/typedefs.dart';

part 'db_tag.freezed.dart';

part 'db_tag.g.dart';

@freezed
class DbTag with _$DbTag {
  const factory DbTag({
    @Default('') Id id,
    @Default('') String text,
    required int colorCode,
  }) = _DbTag;

  factory DbTag.fromJson(Map<String, Object?> json) => _$DbTagFromJson(json);
}
