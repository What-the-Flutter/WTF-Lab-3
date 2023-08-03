// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diary_app/domain/entities/chat.dart';
import 'package:equatable/equatable.dart';

class ChatListChanged extends Equatable {
  final List<Chat> chats;

  ChatListChanged(this.chats);

  ChatListChanged copyWith({
    List<Chat>? chats,
  }) {
    return ChatListChanged(
      chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [
        chats,
        chats.length,
        chats.hashCode,
      ];
}
