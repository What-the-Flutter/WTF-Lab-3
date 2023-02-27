import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../util/typedefs.dart';

part 'firebase_chat_model.freezed.dart';

part 'firebase_chat_model.g.dart';

@freezed
class FirebaseChatModel with _$FirebaseChatModel {
  const factory FirebaseChatModel({
    @Default('_id') FId id,
    @Default('_chat_title') String chatTitle,
    required int chatIcon,
    required DateTime creationDate,
    @Default('') String messages,
    @Default(false) bool isPinned,
    @Default(false) bool isArchive,
  }) = _FirebaseChatModel;

  factory FirebaseChatModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseChatModelFromJson(json);

}
