part of 'chatter_cubit.dart';

@freezed
class ChatterState with _$ChatterState {
  const factory ChatterState({
    required IList<ChatModel> chats,
  }) = _ChatterState;
}
