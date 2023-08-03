import 'package:diary_app/data/all_icons.dart';
import 'package:diary_app/data/models/chat_model.dart';
import 'package:diary_app/data/repositories/local_repository.dart';
import 'package:diary_app/domain/entities/chat.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:diary_app/custom_theme.dart';
import 'package:diary_app/themes.dart';
import 'package:diary_app/presentation/pages/main_screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    join(await getDatabasesPath(), 'diary_app.db'),
    onCreate: (db, version) {
      db.execute('''
          CREATE TABLE chats(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          createdAt INTEGER NOT NULL,
          icon INTEGER NOT NULL,
          title TEXT NOT NULL,
          isPinned INTEGER NOT NULL,
          lastMessage TEXT,
          updatedAt INTEGER
          )
        ''');
      db.execute(
        '''
          CREATE TABLE events(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          chatId INTEGER NOT NULL,
          isFavorite INTEGER NOT NULL,
          isMessage INTEGER NOT NULL,
          dateTime INTEGER NOT NULL,
          message TEXT NOT NULL,
          categoryTitle TEXT,
          categoryIcon INTEGER,
          image TEXT
          )
        ''',
      );
    },
    version: 1,
  );

  final localRepository = LocalRepository(database);

  GetIt.I.registerSingleton<LocalRepository>(localRepository);

  runApp(const CustomTheme(
    initialThemeKey: MyThemesKeys.light,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.of(context),
      title: 'Diary app',
      home: MainScreen(),
    );
  }
}
