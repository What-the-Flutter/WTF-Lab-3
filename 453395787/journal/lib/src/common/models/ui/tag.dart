import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({
    @Default('') String id,
    @Default('') String text,
    required Color color,
  }) = _Tag;
}
