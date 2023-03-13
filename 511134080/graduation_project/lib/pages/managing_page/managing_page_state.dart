part of 'managing_page_cubit.dart';

class ManagingPageState {
  final List<ChatModel> chats;

  ManagingPageState({required this.chats});

  ManagingPageState copyWith({List<ChatModel>? newChats}) =>
      ManagingPageState(chats: newChats ?? chats);
}
