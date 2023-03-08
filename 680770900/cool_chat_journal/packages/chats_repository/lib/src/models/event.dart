import 'package:cool_chat_journal_source/cool_chat_journal_source.dart'
  as data_source show Event;

class Event {
  final int id;
  final String content;
  final bool isImage;
  final bool isFavorite;
  final DateTime changeTime;
  final String? category;

  const Event({
    required this.id,
    required this.content,
    required this.isImage,
    required this.isFavorite,
    required this.changeTime,
    required this.category,
  });

  factory Event.fromSourceEvent(data_source.Event event) =>
    Event(
      id: event.id, 
      content: event.content, 
      isImage: event.isImage, 
      isFavorite: event.isFavorite,
      changeTime: event.changeTime, 
      category: event.category, 
    );

  data_source.Event toSourceEvent({required int chatId}) =>
    data_source.Event(
      id: id,
      chatId: chatId,
      content: content,
      isImage: isImage,
      isFavorite: isFavorite,
      changeTime: changeTime,
      category: category,
    ); 
}
