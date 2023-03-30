part of 'main_page_cubit.dart';

class MainPageState {
  final int selectedIndex;
  final bool isLoaded;

  MainPageState({
    this.selectedIndex = 0,
    this.isLoaded = false,
  });

  MainPageState copyWith({
    int? newSelectedIndex,
    bool? loaded,
  }) =>
      MainPageState(
        selectedIndex: newSelectedIndex ?? selectedIndex,
        isLoaded: loaded ?? isLoaded,
      );
}
