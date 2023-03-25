part of 'managing_page_cubit.dart';

class ManagingPageState {
  final int selectedIndex;
  final bool isCreatingPage;
  final String inputText;
  final String title;

  ManagingPageState({
    this.selectedIndex = 0,
    this.isCreatingPage = true,
    this.inputText = '',
    this.title = 'Create a new Page',
  });

  ManagingPageState copyWith({
    int? index,
    bool? creatingPage,
    String? newInputText,
    String? newTitle,
  }) =>
      ManagingPageState(
        selectedIndex: index ?? selectedIndex,
        isCreatingPage: creatingPage ?? isCreatingPage,
        inputText: newInputText ?? inputText,
        title: newTitle ?? title,
      );
}
