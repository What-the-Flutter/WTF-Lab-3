import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../extensions/date_time_extensions.dart';

part 'db_message.freezed.dart';

part 'db_message.g.dart';

@freezed
class DbMessage with _$DbMessage {
  const DbMessage._();

  factory DbMessage({
    @Default('') String id,
    @Default('') String parentId,
    @Default('') String text,
    required DateTime dateTime,
    @Default(IListConst([])) IList<String> images,
    @Default(IListConst([])) IList<String> tagsId,
    @Default(false) bool isFavorite,
  }) = _DbMessage;

  factory DbMessage.fromJson(Map<String, Object?> json) =>
      _$DbMessageFromJson(json);

  String get time => dateTime.formatTime;

  bool get hasImages => images.isNotEmpty;

  bool get hasSingleImage => images.length == 1;
}
