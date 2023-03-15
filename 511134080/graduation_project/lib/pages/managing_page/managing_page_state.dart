part of 'managing_page_cubit.dart';

class ManagingPageState {
  final List<ChatModel> _chats;
  final int _selectedIndex;
  final bool _isCreatingPage;
  final String _inputText;
  final String _title;
  late final ChatModel _resultPage;

  ManagingPageState({
    required List<ChatModel> chats,
    int selectedIndex = 0,
    bool isCreatingPage = true,
    String inputText = '',
    String title = 'Create a new Page',
  })  : _title = title,
        _inputText = inputText,
        _isCreatingPage = isCreatingPage,
        _selectedIndex = selectedIndex,
        _chats = chats;

  ChatModel get resultPage => _resultPage;

  int get selectedIndex => _selectedIndex;

  String get inputText => _inputText;

  String get title => _title;

  ManagingPageState copyWith({
    List<ChatModel>? newChats,
    int? index,
    bool? creatingPage,
    String? newInputText,
    String? newTitle,
  }) =>
      ManagingPageState(
        chats: newChats ?? _chats,
        selectedIndex: index ?? _selectedIndex,
        isCreatingPage: creatingPage ?? _isCreatingPage,
        inputText: newInputText ?? _inputText,
        title: newTitle ?? _title,
      );
}
