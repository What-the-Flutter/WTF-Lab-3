import 'package:drift/drift.dart';

class MessageIntoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get chatId => integer()();

  IntColumn get messageId => integer()();
}