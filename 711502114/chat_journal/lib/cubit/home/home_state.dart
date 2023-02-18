import '../../models/chat.dart';

class HomeState {
  int id;
  final List<Chat> chats;

  HomeState({required this.chats, required this.id});

  HomeState copyWith({List<Chat>? chats, int? id}) {
    return HomeState(chats: chats ?? this.chats, id: id ?? this.id);
  }
}
