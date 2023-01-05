class MenuState {
  final int index;

  MenuState({required this.index});

  MenuState copyWith(int? index) {
    return MenuState(index: index ?? this.index);
  }
}
