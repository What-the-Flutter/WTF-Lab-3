import '../../../domain/entities/event.dart';

abstract class ChatSearchState {}

class ChatSearchLoaded extends ChatSearchState {
  List<Event> events;
  ChatSearchLoaded({required this.events});
}

class ChatSearchNotLoaded extends ChatSearchState {}

class ChatNotSearch extends ChatSearchState {}
