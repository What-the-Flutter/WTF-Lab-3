import 'package:chats_api/chats_api.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

class NullWrapper<T> {
  final T value;
  const NullWrapper(this.value);
}

class Event extends Equatable {
  final String id;
  final String chatId;
  final String content;
  final bool isImage;
  final bool isFavorite;
  final DateTime changeTime;
  final Category? category;

  Event({
    String? id,
    required this.chatId,
    required this.content,
    required this.isImage,
    required this.isFavorite,
    required this.changeTime,
    this.category,
  }) : id = id ?? const Uuid().v4();

  factory Event.fromEventEntity(EventEntity eventEntity) =>
    Event(
      id: eventEntity.id,
      chatId: eventEntity.chatId,
      content: eventEntity.content,
      isImage: eventEntity.isImage,
      isFavorite: eventEntity.isFavorite,
      changeTime: eventEntity.changeTime,
    ); 

  EventEntity toEventEntity() =>
    EventEntity(
      id: id,
      chatId: chatId,
      content: content,
      isImage: isImage,
      isFavorite: isFavorite,
      changeTime: changeTime,
      category: category?.id,
    );

  Event copyWith({
    String? id,
    String? chatId,
    String? content,
    bool? isImage,
    bool? isFavorite,
    DateTime? changeTime,
    NullWrapper<Category?>? category,
  }) => Event(
    id: id ?? this.id,
    chatId: chatId ?? this.chatId,
    content: content ?? this.content,
    isImage: isImage ?? this.isImage,
    isFavorite: isFavorite ?? this.isFavorite,
    changeTime: changeTime ?? this.changeTime,
    category: category != null ? category.value : this.category,
  ); 
  
  @override
  List<Object?> get props => [
    id,
    chatId,
    content,
    isImage,
    isFavorite,
    changeTime,
    category,
  ];
}
