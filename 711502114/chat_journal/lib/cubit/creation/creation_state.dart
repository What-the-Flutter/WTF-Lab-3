class CreationState {
  final int index;
  final bool isFinished;
  final bool isEditMode;

  CreationState({
    required this.index,
    required this.isFinished,
    this.isEditMode = false,
  });

  CreationState copyWith({int? index, bool? isFinished, bool? isEditMode}) {
    return CreationState(
      index: index ?? this.index,
      isFinished: isFinished ?? this.isFinished,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
