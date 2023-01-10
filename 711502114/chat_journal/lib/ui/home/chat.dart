import 'event/message_data.dart';

class Chat {
  final String title, description;
  final List<MessageData> messages;

  Chat({
    required this.title,
    required this.description,
    required this.messages,
  });
}
