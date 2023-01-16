// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diary_app/domain/entities/event.dart';
import 'package:equatable/equatable.dart';

class ChatEventsUpdated extends Equatable {
  final List<Event> chatEvents;

  ChatEventsUpdated({
    required this.chatEvents,
  });

  ChatEventsUpdated copyWith({
    List<Event>? chatEvents,
  }) {
    return ChatEventsUpdated(
      chatEvents: chatEvents ?? this.chatEvents,
    );
  }

  @override
  List<Object?> get props => [chatEvents.length, chatEvents.hashCode, chatEvents];
}
