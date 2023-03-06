class EventDialogState {
  final bool isEdit;
  final bool isMove;

  EventDialogState({
    required this.isEdit,
    required this.isMove,
  });

  EventDialogState copyWith({bool? isEdit, bool? isMove}) {
    return EventDialogState(
      isEdit: isEdit ?? this.isEdit,
      isMove: isMove ?? this.isMove,
    );
  }
}
