part of 'message_manage_cubit.dart';

@freezed
class MessageManageState with _$MessageManageState {
  const MessageManageState._();

  const factory MessageManageState.defaultMode({
    required String name,
    required IList<Message> messages,
  }) = MessageManageDefaultMode;

  const factory MessageManageState.selectionMode({
    required String name,
    required IList<Message> messages,
    required ISet<int> selected,
  }) = MessageManageSelectionMode;

  const factory MessageManageState.editMode({
    required String name,
    required IList<Message> messages,
    required Message message,
  }) = MessageManageEditMode;

  IList<Object> get messagesWithDates {
    if (messages.isEmpty) {
      return IList([]);
    }

    var bufferDateTime = messages.first.dateTime;
    var list = <Object>[bufferDateTime];

    for (var message in messages) {
      if (!message.dateTime.isSameDay(bufferDateTime)) {
        list.add(message.dateTime);
        bufferDateTime = message.dateTime;
      }
      list.add(message);
    }

    return list.lock;
  }
}
