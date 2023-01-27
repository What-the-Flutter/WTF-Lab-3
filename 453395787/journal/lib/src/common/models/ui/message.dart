import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../extensions/date_time_extensions.dart';
import '../../utils/typedefs.dart';
import 'tag.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const Message._();

  const factory Message({
    @Default('') Id id,
    @Default('') Id parentId,
    @Default('') String text,
    required DateTime dateTime,
    @Default(IListConst([])) IList<Future<File>> images,
    @Default(IListConst([])) IList<Tag> tags,
    @Default(false) bool isFavorite,
  }) = _Message;

  String get time => dateTime.formatTime;

  bool get hasImages => images.isNotEmpty;

  bool get hasSingleImage => images.length == 1;
}
