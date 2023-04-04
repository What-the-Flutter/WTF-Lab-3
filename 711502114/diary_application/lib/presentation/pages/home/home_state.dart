import 'package:diary_application/domain/models/chat.dart';

class HomeState {
  final List<Chat> chats;

  HomeState({required this.chats});

  HomeState copyWith({List<Chat>? chats, int? id}) {
    return HomeState(chats: chats ?? this.chats);
  }
}
