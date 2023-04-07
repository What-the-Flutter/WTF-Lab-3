import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dao/chat_dao.dart';
import '../../dao/event_dao.dart';
import '../../providers/database_provider.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/event_repository.dart';
import '../chat/chat_cubit.dart';
import '../filter_page/filter_page_cubit.dart';
import '../home/home_cubit.dart';
import '../managing_page/managing_page_cubit.dart';
import '../searching_page/searching_page_cubit.dart';
import '../settings/settings_cubit.dart';
import '../statistics_page/label_statistics/label_statistics_cubit.dart';
import '../statistics_page/statistics_page_cubit.dart';
import '../statistics_page/summary_statistics/summary_statistics_cubit.dart';
import '../timeline/timeline_page_cubit.dart';
import '../welcome/welcome_page.dart';

class ChatJournal extends StatefulWidget {
  const ChatJournal();
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
          create: (_) => HomeCubit(
            chatsRepository: chatRepository,
            eventsRepository: eventRepository,
          ),
        ),
        BlocProvider(
          create: (_) => ChatCubit(
            eventsRepository: eventRepository,
          ),
        ),
        BlocProvider(
          create: (_) => ManagingPageCubit(
            chatsRepository: chatRepository,
            initState: ManagingPageState(),
          ),
        ),
        BlocProvider(
          create: (_) => SearchingPageCubit(),
        ),
        BlocProvider(
          create: (_) => TimelinePageCubit(
            eventsRepository: eventRepository,
            chatsRepository: chatRepository,
          ),
        ),
        BlocProvider(
          create: (_) => FilterPageCubit(
            eventsRepository: eventRepository,
            chatsRepository: chatRepository,
          ),
        ),
        BlocProvider(
          create: (_) => StatisticsPageCubit(),
        ),
        BlocProvider(
          create: (_) => LabelStatisticsCubit(
            eventsRepository: eventRepository,
          ),
        ),
        BlocProvider(
          create: (_) => SummaryStatisticsCubit(
            eventsRepository: eventRepository,
          ),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (_, state) => MaterialApp(
          title: 'Chat Journal',
          theme: state.currentTheme,
          debugShowCheckedModeBanner: false,
          home: const WelcomePage(),
        ),
      ),
    );
  }
}
