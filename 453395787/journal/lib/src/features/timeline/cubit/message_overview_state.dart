part of 'message_overview_cubit.dart';

@freezed
class MessageOverviewState with _$MessageOverviewState {
  const MessageOverviewState._();

  const factory MessageOverviewState({
    required MessageList messages,
  }) = _MessageOverviewState;

  IList<Object> get messagesWithDates {
    if (messages.isEmpty) {
      return IList([]);
    }

    var bufferDateTime = messages.first.dateTime;
    final list = <Object>[bufferDateTime];

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
