part of 'chat_overview_cubit.dart';

class ChatOverviewState extends Equatable {
  const ChatOverviewState({required this.chats});

  final List<Chat> chats;

  @override
  List<Object> get props => [chats];
}
