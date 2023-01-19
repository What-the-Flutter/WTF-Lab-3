import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../extensions/date_time_extensions.dart';
import '../utils/typedefs.dart';

part 'message.freezed.dart';

part 'message.g.dart';

@freezed
class Message with _$Message {
  const Message._();

  factory Message({
    @Default('') Id id,
    @Default('') Id parentId,
    @Default('') String text,
    required DateTime dateTime,
    @Default(IListConst([])) IList<String> images,
    @Default(IListConst([])) IList<Id> tagsId,
    @Default(false) bool isFavorite,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);

  String get time => dateTime.formatTime;

  bool get hasImages => images.isNotEmpty;

  bool get hasSingleImage => images.length == 1;
}
