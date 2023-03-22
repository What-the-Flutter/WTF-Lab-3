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
import 'pages/settings/settings_cubit.dart';
import 'pages/singInAnonymously.dart';
import 'repositories/chat_repository.dart';
import 'repositories/event_repository.dart';

class ChatJournal extends StatefulWidget {
  late final DatabaseProvider dbProvider;
  late final ChatDao chatDao;
  late final EventDao eventDao;
  late final ChatRepository chatRepository;
  late final EventRepository eventRepository;
  ChatJournal();
  @override
  State<ChatJournal> createState() => _ChatJournalState();
}

class _ChatJournalState extends State<ChatJournal> {
  @override
  void initState() {
    super.initState();
    SignInAnonymously.signInAnonymously();
    widget.dbProvider = DatabaseProvider();
    widget.chatDao = ChatDao(dbProvider: widget.dbProvider);
    widget.eventDao = EventDao(dbProvider: widget.dbProvider);
    widget.chatRepository = ChatRepository(chatDao: widget.chatDao);
    widget.eventRepository = EventRepository(eventDao: widget.eventDao);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(
            chatsRepository: widget.chatRepository,
            eventsRepository: widget.eventRepository,
          ),
        ),
        BlocProvider(
          create: (context) => ChatCubit(
            eventsRepository: widget.eventRepository,
          ),
        ),
        BlocProvider(
          create: (context) => ManagingPageCubit(
            chatsRepository: widget.chatRepository,
            initState: ManagingPageState(),
          ),
        ),
        BlocProvider(
          create: (_) => SettingsCubit(),
        ),
        BlocProvider(
          create: (_) => SearchingPageCubit(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
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
