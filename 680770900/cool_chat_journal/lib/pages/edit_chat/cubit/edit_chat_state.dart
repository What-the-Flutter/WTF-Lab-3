class EditChatState {
  final int iconIndex;
  final String title;

  const EditChatState({
    this.iconIndex = 0,
    this.title = '',
  });

  EditChatState copyWith({
    int? iconIndex,
    String? title,
  }) => EditChatState(
    iconIndex: iconIndex ?? this.iconIndex,
    title: title ?? this.title,
  );
}