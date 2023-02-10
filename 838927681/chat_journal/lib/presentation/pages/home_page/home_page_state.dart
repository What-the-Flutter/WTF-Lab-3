import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';

class HomePageState extends Equatable {
  final List<Chat> chats;
  final Event? lastEvent;

  const HomePageState({required this.chats, this.lastEvent});

  HomePageState copyWith({List<Chat>? chats, Event? lastEvent}) {
    return HomePageState(
      chats: chats ?? this.chats,
      lastEvent: lastEvent ?? this.lastEvent,
    );
  }

  @override
  List<Object?> get props => [chats];
}
