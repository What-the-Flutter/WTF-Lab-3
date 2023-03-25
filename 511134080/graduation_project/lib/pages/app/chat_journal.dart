import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dao/chat_dao.dart';
import '../../dao/event_dao.dart';
import '../../providers/database_provider.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/event_repository.dart';
import '../chat/chat_cubit.dart';
import '../home/home_cubit.dart';
import '../home/home_page.dart';
import '../managing_page/managing_page_cubit.dart';
import '../searching_page/searching_page_cubit.dart';
import '../settings/settings_cubit.dart';
import 'app_cubit.dart';

class ChatJournal extends StatefulWidget {
  ChatJournal();
  @override
  State<ChatJournal> createState() => _ChatJournalState();
}

class _ChatJournalState extends State<ChatJournal> {
  late final DatabaseProvider dbProvider;
  late final ChatDao chatDao;
  late final EventDao eventDao;
  late final ChatRepository chatRepository;
  late final EventRepository eventRepository;
  @override
  void initState() {
    super.initState();
    dbProvider = DatabaseProvider();
    chatDao = ChatDao(dbProvider: dbProvider);
    eventDao = EventDao(dbProvider: dbProvider);
    chatRepository = ChatRepository(chatDao: chatDao);
    eventRepository = EventRepository(eventDao: eventDao);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppCubit(),
        ),
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
            theme: state.currentTheme,
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
