import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../extensions/date_time_extensions.dart';
import 'tag.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const Message._();

  factory Message._internal({
    required int id,
    required String text,
    required DateTime dateTime,
    required IList<String> images,
    required IList<Tag> tags,
    required bool isFavorite,
  }) = _Message;

  factory Message({
    int? id,
    String text = '',
    DateTime? dateTime,
    IList<String> images = const IListConst([]),
    IList<Tag> tags = const IListConst([]),
    bool isFavorite = false,
  }) =>
      Message._internal(
        id: id ?? Random().nextInt(10000),
        text: text,
        dateTime: dateTime ?? DateTime.now(),
        images: images,
        tags: tags,
        isFavorite: isFavorite,
      );

  String get time => dateTime.formatTime;

  bool get hasImages => images.isNotEmpty;

  bool get hasSingleImage => images.length == 1;
}
