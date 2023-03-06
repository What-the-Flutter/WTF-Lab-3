import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../util/typedefs.dart';

part 'firebase_message_model.freezed.dart';

part 'firebase_message_model.g.dart';

@freezed
class FirebaseMessageModel with _$FirebaseMessageModel {
  const factory FirebaseMessageModel({
    @Default('_id') FId id,
    required String chatId,
    @Default('_message_text') String messageText,
    required DateTime sendDate,
    @Default(IListConst([])) IList<FId> tagsIds,
    @Default(IListConst([])) IList<FId> imagePaths,
    @Default(false) bool isFavorite,
  }) = _FirebaseMessageModel;

  factory FirebaseMessageModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessageModelFromJson(json);
}
