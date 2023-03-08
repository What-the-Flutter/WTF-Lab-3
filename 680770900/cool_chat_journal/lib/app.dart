import 'package:chats_repository/chats_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chats/chats.dart';
import 'themes/custom_theme.dart';

class CoolChatJournalApp extends StatelessWidget {
  const CoolChatJournalApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return CustomTheme(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Cool Chat Journal',
            theme: CustomTheme.of(context),
            home: RepositoryProvider.value(
              value: ChatsRepository(),
              child: const ChatsPage(),
            ),
          );
        }
      ),
    );
  }
}
