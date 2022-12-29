// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatRepository {
  static final _instance = ChatRepository._internal();

  factory ChatRepository.get() => _instance;

  ChatRepository._internal() {
    chats = [
      Chat(
        id: 0,
        name: 'All',
        icon: Icons.all_inclusive_outlined,
        creationDate: DateTime.parse('2022-12-19 12:29:00'),
        messages: IList(
          [
            Message(
                id: 1,
                dateTime: DateTime.parse('2022-12-19 12:30:00'),
                text: 'Hello'),
            Message(
                id: 2,
                dateTime: DateTime.parse('2022-12-20 13:30:00'),
                text: 'Some long message'),
            Message(
                id: 3,
                dateTime: DateTime.parse('2022-12-21 17:15:00'),
                text: 'Another message',
                isFavorite: true),
            Message(
                id: 4,
                dateTime: DateTime.parse('2022-12-21 17:16:24'),
                text: 'message with chips'),
          ],
        ),
      ),
      Chat(
        id: 1,
        name: 'Sport',
        icon: Icons.sports_volleyball_outlined,
        creationDate: DateTime.parse('2022-12-21 21:01:00'),
        messages: IList(
          [
            Message(id: 1, text: 'Some Text'),
            Message(id: 2, text: 'Some Text'),
            Message(id: 3, text: 'Some Text'),
          ],
        ),
      ),
      Chat(
        id: 2,
        name: 'University',
        icon: Icons.science_outlined,
        creationDate: DateTime.parse('2022-11-11 11:11:00'),
        messages: IList(
          [
            Message(id: 1, text: 'Some Text'),
            Message(id: 2, text: 'Some Text'),
            Message(id: 3, text: 'Some Text'),
          ],
        ),
      ),
      Chat(
        id: 3,
        name: 'Other',
        icon: Icons.stadium_outlined,
        creationDate: DateTime.parse('2022-12-28 17:01:00'),
        messages: IList(
          [
            Message(id: 1, text: 'Some Text'),
            Message(id: 2, text: 'Some Text'),
            Message(id: 3, text: 'Some Text'),
          ],
        ),
      ),
    ].lock;
  }

  IList<Chat> chats = IList([]);

  IList<int> get chatOrder {
    return chats
        .whereMoveToTheStart((item) => item.isPinned)
        .map((item) => item.id)
        .toIList();
  }

  IList<Chat> get orderedChats {
    var chats = IList<Chat>([]);
    for (var id in chatOrder) {
      chats = chats.add(
        this.chats.firstWhere((e) => e.id == id),
      );
    }
    return chats;
  }
}

class Chat {
  final int id;
  final String name;
  final IconData icon;
  final DateTime creationDate;
  final bool isPinned;
  final IList<Message> messages;

  Chat({
    required this.id,
    required this.name,
    required this.icon,
    bool? isPinned,
    DateTime? creationDate,
    required this.messages,
  })  : isPinned = isPinned ?? false,
        creationDate = creationDate ?? DateTime.now();

  Message? get lastMessage => messages.isEmpty ? null : messages.last;

  Chat copyWith({
    int? id,
    String? name,
    IconData? icon,
    IList<Message>? messages,
    bool? isPinned,
    DateTime? creationDate,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      messages: messages ?? this.messages,
      isPinned: isPinned ?? this.isPinned,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}

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

  String get time => DateFormat.jm().format(dateTime);
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
