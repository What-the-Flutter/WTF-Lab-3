part of '../chat_database.dart';

class MessageToChatTable extends Table {
  IntColumn get uid => integer().autoIncrement()();

  IntColumn get chatId => integer()();

  IntColumn get messageId => integer()();
}
