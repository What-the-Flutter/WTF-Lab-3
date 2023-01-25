import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class MessageModel {
  final int id;
  final String messageText;
  final DateTime sendDate;
  final IList<String> images;
  final bool isFavorite;

  MessageModel({
    int? id,
    this.messageText = '',
    DateTime? sendDate,
    IList<String>? images,
    bool? isFavorite,
  })  : id = id ?? Random().nextInt(10000),
        sendDate = sendDate ?? DateTime.now(),
        images = images ?? IList(),
        isFavorite = isFavorite ?? false;

  MessageModel copyWith({
    int? id,
    String? messageText,
    DateTime? sendDate,
    IList<String>? images,
    bool? isFavorite,
  }) {
    return MessageModel(
      id: id ?? this.id,
      messageText: messageText ?? this.messageText,
      sendDate: sendDate ?? this.sendDate,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
