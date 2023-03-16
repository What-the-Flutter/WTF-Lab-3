part of 'managing_page_cubit.dart';

class ManagingPageState {
  final int _selectedIndex;
  final bool _isCreatingPage;
  final String _inputText;
  final String _title;

  final chatsRepository = ChatRepository();

  ManagingPageState({
    int selectedIndex = 0,
    bool isCreatingPage = true,
    String inputText = '',
    String title = 'Create a new Page',
  })  : _title = title,
        _inputText = inputText,
        _isCreatingPage = isCreatingPage,
        _selectedIndex = selectedIndex;

  int get selectedIndex => _selectedIndex;

  String get inputText => _inputText;

  String get title => _title;

  ManagingPageState copyWith({
    int? index,
    bool? creatingPage,
    String? newInputText,
    String? newTitle,
  }) =>
      ManagingPageState(
        selectedIndex: index ?? _selectedIndex,
        isCreatingPage: creatingPage ?? _isCreatingPage,
        inputText: newInputText ?? _inputText,
        title: newTitle ?? _title,
      );
}
