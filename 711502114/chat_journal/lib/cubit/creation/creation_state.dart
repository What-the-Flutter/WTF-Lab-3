class CreationState {
  final int index;
  final bool isFinished;

  CreationState({required this.index, required this.isFinished});

  CreationState copyWith({int? index, bool? isFinished}) {
    return CreationState(
      index: index ?? this.index,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
