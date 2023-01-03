import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../utils/extensions.dart';

class Message {
  final int id;
  final DateTime dateTime;
  final String text;
  final IList<String> images;
  final IList<String> tags;
  final bool isFavorite;

  Message({
    int? id,
    DateTime? dateTime,
    this.text = '',
    IList<String>? images,
    IList<String>? tags,
    this.isFavorite = false,
  })  : id = id ?? Random().nextInt(1000),
        images = images ?? <String>[].lock,
        tags = tags ?? <String>[].lock,
        dateTime = dateTime ?? DateTime.now();

  String get time => dateTime.formatTime;
  bool get hasImages => images.isNotEmpty;
  bool get hasSingleImage => images.length == 1;

  Message copyWith({
    int? id,
    DateTime? dateTime,
    String? text,
    IList<String>? images,
    IList<String>? tags,
    bool? isFavorite,
  }) {
    return Message(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      text: text ?? this.text,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
