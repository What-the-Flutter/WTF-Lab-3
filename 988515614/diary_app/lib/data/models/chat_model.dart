import 'package:diary_app/data/all_icons.dart';
import 'package:diary_app/domain/entities/chat.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  final int createdAt;
  int icon;
  String title;
  String? lastMessage;
  int? updatedAt;
  bool isPinned;

  ChatModel({
    required this.createdAt,
    required this.icon,
    required this.title,
    required this.isPinned,
    this.lastMessage,
    this.updatedAt,
  });

  Chat toChat() {
    return Chat(
      id: 0,
      icon: allIcons[icon],
      title: title,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      lastMessage: lastMessage,
      updatedAt: updatedAt != null ? DateTime.fromMillisecondsSinceEpoch(updatedAt!) : null,
      isPinned: isPinned,
    );
  }

  ChatModel.fromChat(Chat chat)
      : createdAt = chat.createdAt.millisecondsSinceEpoch,
        icon = allIcons.indexOf(chat.icon),
        title = chat.title,
        isPinned = chat.isPinned,
        lastMessage = chat.lastMessage,
        updatedAt = chat.updatedAt != null ? chat.updatedAt!.millisecondsSinceEpoch : null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'icon': icon,
      'title': title,
      'lastMessage': lastMessage,
      'updatedAt': updatedAt,
      'isPinned': boolToInt(isPinned),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      createdAt: map['createdAt'] as int,
      icon: map['icon'] as int,
      title: map['title'] as String,
      lastMessage: map['lastMessage'] != null ? map['lastMessage'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as int : null,
      isPinned: intToBool(map['isPinned']),
    );
  }

  static int boolToInt(bool value) {
    return value ? 1 : 0;
  }

  static bool intToBool(int value) {
    return value == 1 ? true : false;
  }
}
