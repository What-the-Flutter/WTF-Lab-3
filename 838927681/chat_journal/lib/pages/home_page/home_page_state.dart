import 'package:equatable/equatable.dart';

import '../../models/chat.dart';

class HomePageState extends Equatable {
  final List<Chat> chats;

  const HomePageState({required this.chats});

  HomePageState copyWith({List<Chat>? chats}) {
    return HomePageState(chats: chats ?? this.chats);
  }

  @override
  List<Object?> get props => [chats];
}
