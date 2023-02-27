import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../util/typedefs.dart';

part 'firebase_tag_model.freezed.dart';

part 'firebase_tag_model.g.dart';

@freezed
class FirebaseTagModel with _$FirebaseTagModel {
  const factory FirebaseTagModel({
    @Default('_id') FId id,
    @Default('_tag_title') String tagTitle,
    @Default(0) int tagIcon,
  }) = _FirebaseTagModel;

  factory FirebaseTagModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseTagModelFromJson(json);
}
