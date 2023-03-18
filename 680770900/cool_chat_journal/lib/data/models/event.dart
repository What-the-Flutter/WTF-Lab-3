import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'json_kit.dart';

part 'event.g.dart';

class NullWrapper<T> {
  final T value;
  const NullWrapper(this.value);
}

@JsonSerializable()
class Event {
  final String id;
  final String content;
  final DateTime changeTime;
  final String chatId;
  final String? categoryId;

  @BooleanConverter()
  final bool isImage;

  @BooleanConverter()
  final bool isFavorite;

  Event({
    String? id,
    required this.content,
    required this.isImage,
    required this.isFavorite,
    required this.changeTime,
    required this.chatId,
    required this.categoryId,
  }) : id = id ?? const Uuid().v4();

  factory Event.fromJson(JsonMap json) => _$EventFromJson(json);

  JsonMap toJson() => _$EventToJson(this); 

  Event copyWith({
    String? id,
    String? content,
    bool? isImage,
    bool? isFavorite,
    DateTime? changeTime,
    String? chatId,
    NullWrapper<String?>? categoryId,
  }) => Event(
    id: id ?? this.id,
    content: content ?? this.content,
    isImage: isImage ?? this.isImage,
    isFavorite: isFavorite ?? this.isFavorite,
    changeTime: changeTime ?? this.changeTime,
    chatId: chatId ?? this.chatId,
    categoryId: categoryId != null 
      ? categoryId.value
      : this.categoryId,
  );
}