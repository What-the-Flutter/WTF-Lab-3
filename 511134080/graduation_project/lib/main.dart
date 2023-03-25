import 'package:flutter/material.dart';

import 'chat_journal.dart';
import 'dao/chat_dao.dart';
import 'dao/event_dao.dart';
import 'database/database_provider.dart';
import 'repositories/chat_repository.dart';
import 'repositories/event_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dbProvider = DatabaseProvider();
  final chatDao = ChatDao(dbProvider: dbProvider);
  final eventDao = EventDao(dbProvider: dbProvider);
  final chatRepository = ChatRepository(chatDao: chatDao);
  final eventRepository = EventRepository(eventDao: eventDao);
  runApp(
    ChatJournal(
      dbProvider: dbProvider,
      chatDao: chatDao,
      chatRepository: chatRepository,
      eventDao: eventDao,
      eventRepository: eventRepository,
    ),
  );
}
