import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dao/chat_dao.dart';
import 'dao/event_dao.dart';
import 'database/database_provider.dart';
import 'pages/chat/chat_cubit.dart';
import 'pages/home/home_cubit.dart';
import 'pages/home/home_page.dart';
import 'pages/managing_page/managing_page_cubit.dart';
import 'pages/searching_page/searching_page_cubit.dart';
import 'repositories/chat_repository.dart';
import 'repositories/event_repository.dart';
import 'theme/theme_cubit.dart';

class ChatJournal extends StatelessWidget {
  final DatabaseProvider dbProvider;
  final ChatDao chatDao;
  final EventDao eventDao;
  final ChatRepository chatRepository;
  final EventRepository eventRepository;
  const ChatJournal(
      {required this.chatRepository,
      required this.eventRepository,
      required this.chatDao,
      required this.dbProvider,
      required this.eventDao,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(
            chatsRepository: chatRepository,
            eventsRepository: eventRepository,
          ),
        ),
        BlocProvider(
          create: (context) => ChatCubit(
            eventsRepository: eventRepository,
          ),
        ),
        BlocProvider(
          create: (context) => ManagingPageCubit(
            chatsRepository: chatRepository,
            initState: ManagingPageState(),
          ),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => SearchingPageCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Chat Journal',
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (_) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
