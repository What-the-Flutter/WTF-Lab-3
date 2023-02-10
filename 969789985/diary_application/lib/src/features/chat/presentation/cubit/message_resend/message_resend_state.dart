part of 'message_resend_cubit.dart';

@freezed
class MessageResendState with _$MessageResendState {
  const factory MessageResendState({
    required IList<ChatModel> chats,
    required IMap<int, bool> selectedChats,
  }) = _MessageResendState;
}
