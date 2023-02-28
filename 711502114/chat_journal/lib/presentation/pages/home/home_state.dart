import '../../../domain/models/chat.dart';

class HomeState {
  final int id;
  final List<Chat> chats;

  HomeState({required this.chats, required this.id});

  HomeState copyWith({List<Chat>? chats, int? id}) {
    return HomeState(chats: chats ?? this.chats, id: id ?? this.id);
  }
}
