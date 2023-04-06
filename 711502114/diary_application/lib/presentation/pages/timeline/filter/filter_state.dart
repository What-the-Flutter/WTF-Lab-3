import 'package:diary_application/domain/models/chat.dart';
import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final List<Chat> chats;
  final List<String> chatTitles;
  final bool isIgnore;

  const FilterState({
    required this.chats,
    required this.chatTitles,
    required this.isIgnore,
  });

  FilterState copyWith({
    List<Chat>? chats,
    List<String>? chatTitles,
    bool? isIgnore,
  }) {
    return FilterState(
      chats: chats ?? this.chats,
      chatTitles: chatTitles ?? this.chatTitles,
      isIgnore: isIgnore ?? this.isIgnore,
    );
  }

  @override
  List<Object?> get props => [chats, chatTitles, isIgnore];
}
