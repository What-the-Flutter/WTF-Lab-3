part of 'message_control_cubit.dart';

@freezed
class MessageControlState with _$MessageControlState {
  const MessageControlState._();

  const factory MessageControlState.defaultMode({
    required IList<MessageModel> messages,
    required IMap<String, bool> selected,
    required MessageModel message,
    required int selectedCount,
    required bool isSelectMode,
    required bool isEditMode,
    required bool isFavoriteMode,
    required bool selectionVisible,
  }) = _DefaultMode;

  const factory MessageControlState.manageMode({
    required IList<MessageModel> messages,
    required IMap<String, bool> selected,
    required MessageModel message,
    required int selectedCount,
    required bool isSelectMode,
    required bool isEditMode,
    required bool isFavoriteMode,
    required bool selectionVisible,
  }) = _ManageMode;
}
