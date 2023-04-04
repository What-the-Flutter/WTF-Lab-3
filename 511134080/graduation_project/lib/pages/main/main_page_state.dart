part of 'main_page_cubit.dart';

class MainPageState {
  final int selectedIndex;
  final bool isAuthenticated;

  MainPageState({
    this.isAuthenticated = false,
    this.selectedIndex = 0,
  });

  MainPageState copyWith({
    bool? authenticated,
    int? newSelectedIndex,
  }) =>
      MainPageState(
        isAuthenticated: authenticated ?? isAuthenticated,
        selectedIndex: newSelectedIndex ?? selectedIndex,
      );
}
