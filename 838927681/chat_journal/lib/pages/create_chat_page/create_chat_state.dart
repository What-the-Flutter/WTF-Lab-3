class CreateChatState {
  final int selectedIconIndex;
  final bool isNotEmpty;
  final bool isCreatingMode;
  final bool isChanged;

  const CreateChatState({
    required this.selectedIconIndex,
    required this.isNotEmpty,
    required this.isCreatingMode,
    required this.isChanged,
  });

  CreateChatState copyWith({
    int? selectedIconIndex,
    bool? isNotEmpty,
    bool? isCreatingMode,
    bool? isChanged,
  }) {
    return CreateChatState(
      selectedIconIndex: selectedIconIndex ?? this.selectedIconIndex,
      isNotEmpty: isNotEmpty ?? this.isNotEmpty,
      isCreatingMode: isCreatingMode ?? this.isCreatingMode,
      isChanged: isChanged ?? this.isChanged,
    );
  }
}
