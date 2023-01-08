part of 'manage_chat_cubit.dart';

@freezed
class ManageChatState with _$ManageChatState {
  const ManageChatState._();

  const factory ManageChatState.adding({
    int? selectedIcon,
    @Default('') String name,
  }) = ManageChatAdding;

  const factory ManageChatState.editing({
    int? selectedIcon,
    @Default('') String name,
    required Chat chat,
  }) = ManageChatEditing;

  const factory ManageChatState.closed({
    int? selectedIcon,
    @Default('') String name,
  }) = ManageChatClosed;

  bool get isFabShown => selectedIcon != null && name.isNotEmpty;
}
