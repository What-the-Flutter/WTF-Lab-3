import 'dart:core';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:diary_application/src/core/domain/models/local/activity/activity_model.dart';
import 'package:diary_application/src/core/domain/models/local/chat/chat_model.dart';
import 'package:diary_application/src/core/domain/models/local/message/message_model.dart';

abstract class MockedActivities {
  static final now = DateTime.now();

  static final activities = IList<ActivityModel>([
    ActivityModel(id: '0', date: now, spentTime: 120),
    ActivityModel(id: '1', date: now.copyWith(day: now.day - 1), spentTime: 74),
    ActivityModel(
        id: '2', date: now.copyWith(day: now.day - 2), spentTime: 120),
    ActivityModel(
        id: '3', date: now.copyWith(day: now.day - 3), spentTime: 180),
    ActivityModel(
        id: '4', date: now.copyWith(day: now.day - 4), spentTime: 500),
    ActivityModel(
        id: '5', date: now.copyWith(day: now.day - 5), spentTime: 120),
    ActivityModel(
        id: '6', date: now.copyWith(day: now.day - 6), spentTime: 590),
  ]);
}

abstract class MockedChats {
  static final chats = IList<ChatModel>([
    ChatModel(
      id: '0',
      chatTitle: '0',
      chatIcon: 0,
    ),
    ChatModel(
      id: '1',
      chatTitle: '1',
      chatIcon: 0,
    ),
    ChatModel(
      id: '2',
      chatTitle: '2',
      chatIcon: 0,
    ),
    ChatModel(
      id: '3',
      chatTitle: '3',
      chatIcon: 0,
    ),
  ]);
}

abstract class MockedMessages {
  //List of messages where the message with parentId == 3 occurs most often
  static final messages = IList([
    MessageModel(parentId: '1'),
    MessageModel(parentId: '2'),
    MessageModel(parentId: '3'),
    MessageModel(parentId: '3'),
    MessageModel(parentId: '3'),
    MessageModel(parentId: '1'),
    MessageModel(parentId: '3'),
    MessageModel(parentId: '2'),
    MessageModel(parentId: '0'),
    MessageModel(parentId: '1'),
    MessageModel(parentId: '1'),
    MessageModel(parentId: '3'),
    MessageModel(parentId: '3'),
    MessageModel(parentId: '3'),
    MessageModel(parentId: '3'),
  ]);
}
