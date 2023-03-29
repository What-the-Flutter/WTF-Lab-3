import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../utils/null_wrapper.dart';
import '../json_kit.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String id;
  final String? content;
  final DateTime changeTime;
  final String chatId;
  final String? categoryId;

  @BooleanConverter()
  final bool isFavorite;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Uint8List? image;

  Event({
    String? id,
    this.content,
    this.image,
    required this.isFavorite,
    required this.changeTime,
    required this.chatId,
    required this.categoryId,
  }) : id = id ?? const Uuid().v4();

  factory Event.fromJson(JsonMap json) => _$EventFromJson(json);

  JsonMap toJson() => _$EventToJson(this);

  Event copyWith({
    String? id,
    NullWrapper<String?>? content,
    NullWrapper<Uint8List?>? image,
    bool? isFavorite,
    DateTime? changeTime,
    String? chatId,
    NullWrapper<String?>? categoryId,
  }) =>
      Event(
        id: id ?? this.id,
        isFavorite: isFavorite ?? this.isFavorite,
        changeTime: changeTime ?? this.changeTime,
        chatId: chatId ?? this.chatId,
        content: content != null ? content.value : this.content,
        image: image != null ? image.value : this.image,
        categoryId: categoryId != null ? categoryId.value : this.categoryId,
      );
}
