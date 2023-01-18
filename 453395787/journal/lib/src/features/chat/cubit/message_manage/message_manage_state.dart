part of 'message_manage_cubit.dart';

@freezed
class MessageManageState with _$MessageManageState {
  const MessageManageState._();

  const factory MessageManageState.defaultModeState({
    required int id,
    required String name,
    required MessageList messages,
  }) = MessageManageDefaultModeState;

  const factory MessageManageState.selectionModeState({
    required int id,
    required String name,
    required MessageList messages,
    required ISet<int> selected,
  }) = MessageManageSelectionModeState;

  const factory MessageManageState.editModeState({
    required int id,
    required String name,
    required MessageList messages,
    required Message message,
  }) = MessageManageEditModeState;

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

  bool? get hasMoreFavoritesInSelected {
    return mapOrNull(
      selectionModeState: (selectionModeState) {
        var amountOfFavorites = 0;
        var amountOfOther = 0;

        final selectedMessages = selectionModeState.messages.where(
          (message) => selectionModeState.selected.contains(
            message.id,
          ),
        );

        for (var message in selectedMessages) {
          message.isFavorite ? amountOfFavorites++ : amountOfOther++;
        }

        return amountOfFavorites > amountOfOther;
      },
    );
  }
}
