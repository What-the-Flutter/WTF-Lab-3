import '../models/chat.dart';

class EventsState {
  Chat chat;

  EventsState(this.chat);

  EventsState copyWith({Chat? updated}) => EventsState(updated ?? chat);
}
