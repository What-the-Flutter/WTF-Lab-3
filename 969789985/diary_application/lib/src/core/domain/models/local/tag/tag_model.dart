import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.freezed.dart';

@freezed
class TagModel with _$TagModel {
  TagModel._();

  factory TagModel.internal({
    required String id,
    required String tagTitle,
    required int tagIcon,
  }) = _TagModel;

  factory TagModel({
    String? id,
    String? tagTitle,
    int? tagIcon,
  }) =>
      TagModel.internal(
        id: id ?? '_id',
        tagTitle: tagTitle ?? '',
        tagIcon: tagIcon ?? 0,
      );
}
