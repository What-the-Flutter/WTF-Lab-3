import 'package:flutter/material.dart';

import '../../domain/entities/chat.dart';

class ChatDTO {
  final int? id;
  final String name;
  final DateTime createTime;
  final IconData pageIcon;
  final bool isPinned;

  ChatDTO(
      {this.id,
      required this.name,
      required this.createTime,
      required this.pageIcon,
      required this.isPinned});

  factory ChatDTO.fromJSON(Map<String, dynamic> json) {
    return ChatDTO(
      id: json['chat_id'],
      name: json['name'],
      createTime: DateTime.parse(json['create_time']),
      pageIcon: IconData(
        int.parse(json['page_icon']),
        fontFamily: 'MaterialIcons',
      ),
      isPinned: json['is_pinned'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'create_time': createTime.toString(),
        'page_icon': pageIcon.codePoint,
        'is_pinned': isPinned ? 1 : 0,
      };

  Chat toModel() {
    return Chat(
      id: id,
      name: name,
      createTime: createTime,
      pageIcon: pageIcon,
      pinnedState: isPinned,
    );
  }
}
