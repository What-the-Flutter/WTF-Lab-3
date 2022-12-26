import 'message.dart';

class MessageValue {
  static final List<Message> listMessage = [
    Message(
      messageContent: 'Hello Maksim',
      messageType: 'sender',
      messageTime: DateTime.now(),
    )..isFavorit = true,
    Message(
      messageContent: 'Hello Sasha r322222222222222222222222222222222r332r',
      messageType: 'recipient',
      messageTime: DateTime.now(),
    ),
    Message(
      messageContent: 'Hello Vlada225523748321',
      messageType: 'sender',
      messageTime: DateTime.now(),
    ),
    Message(
      messageContent: 'Today',
      messageType: 'sender',
      messageTime: DateTime.now(),
    )..isDay = true,
  ];
}
