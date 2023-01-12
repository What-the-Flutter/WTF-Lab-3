import '../../utils/utils.dart';
import 'event/message_data.dart';

class Chat {
  final String title;
  final List<MessageData> messages;

  String _description = '';

  Chat({
    required this.title,
    required this.messages,
  }) {
    if (messages.isNotEmpty) {
      final messageData = messages[messages.length - 1];
      _description = messageData.message;
    }
  }

  bool get isDescriptionEmpty => _description.isEmpty;

  String get description => _description;
}
