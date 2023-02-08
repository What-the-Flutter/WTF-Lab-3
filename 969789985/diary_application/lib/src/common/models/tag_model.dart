import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.freezed.dart';

@freezed
class TagModel with _$TagModel {
  TagModel._();

  factory TagModel.internal({
    required int id,
    required String tagTitle,
    required int tagIcon,
  }) = _TagModel;

  factory TagModel({
    int? id,
    String? tagTitle,
    int? tagIcon,
  }) =>
      TagModel.internal(
        id: id ?? Random().nextInt(10000),
        tagTitle: tagTitle ?? '',
        tagIcon: tagIcon ?? 0,
      );
}
