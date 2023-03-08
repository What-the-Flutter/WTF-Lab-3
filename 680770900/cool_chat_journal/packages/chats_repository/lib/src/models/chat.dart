import 'package:chats_api/chats_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

class Chat extends Equatable {
  final String id;
  final IconData icon;
  final String name;
  final DateTime createdTime;
  final bool isPinned;
  final List<Event> events;

  Chat({
    String? id,
    required this.icon,
    required this.name,
    required this.createdTime,
    required this.isPinned,
    this.events = const [],
  }) : id = id ?? const Uuid().v4();

  factory Chat.fromChatEntity(ChatEntity chatEntity) => 
    Chat(
      id: chatEntity.id,
      icon: IconData(chatEntity.icon, fontFamily: 'MaterialIcons'),
      name: chatEntity.name,
      createdTime: chatEntity.createdTime,
      isPinned: chatEntity.isPinned,
    );

  ChatEntity toChatEntity() => 
    ChatEntity(
      id: id,
      name: name,
      icon: icon.codePoint,
      createdTime: createdTime,
      isPinned: isPinned,
    );

  Chat copyWith({
    String? id,
    IconData? icon,
    String? name,
    DateTime? createdTime,
    bool? isPinned,
    List<Event>? events,
  }) => Chat(
    id: id ?? this.id,
    icon: icon ?? this.icon,
    name: name ?? this.name,
    createdTime: createdTime ?? this.createdTime,
    isPinned: isPinned ?? this.isPinned,
    events: events ?? this.events,
  );
  
  @override
  List<Object?> get props => [
    id,
    icon,
    name,
    createdTime,
    isPinned,
    events,
  ];
}
