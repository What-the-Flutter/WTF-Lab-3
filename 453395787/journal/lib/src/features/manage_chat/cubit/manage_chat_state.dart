part of 'manage_chat_cubit.dart';

@freezed
class ManageChatState with _$ManageChatState {
  const ManageChatState._();

  const factory ManageChatState.adding({
    int? selectedIcon,
    @Default('') String name,
  }) = _AddModeState;

  const factory ManageChatState.editing({
    int? selectedIcon,
    required String name,
    required ChatView chat,
  }) = _EditModeState;

  bool get isAddMode => this is _AddModeState;

  bool get isEditMode => this is _EditModeState;
}
