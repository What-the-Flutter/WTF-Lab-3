import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/chat.dart';
import '../models/event.dart';
import '../theme/colors.dart';
import '../theme/fonts.dart';
import '../theme/theme_cubit.dart';
import '../theme/theme_state.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/theme_button.dart';
import 'chat_page/chat_page_cubit.dart';
import 'create_chat_page/create_chat_cubit.dart';
import 'home_page/home.dart';
import 'home_page/home_page_cubit.dart';

final _chats = <Chat>[
  Chat(
      id: 0,
      name: 'Travel',
      iconIndex: 0,
      creationDate: DateTime.now().subtract(const Duration(days: 1)),
      events: []),
  Chat(
    id: 1,
    name: 'Family',
    iconIndex: 1,
    creationDate: DateTime.now().subtract(const Duration(days: 2)),
    events: [
      Event(
          text: 'My Family',
          dateTime: DateTime.now().subtract(const Duration(hours: 24))),
      Event(text: 'My big big family', dateTime: DateTime.now()),
    ],
  ),
  Chat(
    id: 2,
    name: 'Sport',
    iconIndex: 2,
    events: [],
    creationDate: DateTime.now().subtract(const Duration(days: 3)),
  ),
];

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  final title = 'Home';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
          lazy: false,
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
        BlocProvider<CreateChatCubit>(
          create: (context) => CreateChatCubit(isCreatingMode: true),
        ),
        BlocProvider<HomePageCubit>(
          create: (context) => HomePageCubit(_chats),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.theme,
            home: _mainPage(context),
          );
        },
      ),
    );
  }

  Widget _mainPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        centerTitle: true,
        actions: const [
          ThemeButton(),
        ],
      ),
      drawer: _drawer(context),
      body: const HomePage(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: BlocProvider.of<ThemeCubit>(context).isLight()
                  ? ChatJournalColors.green
                  : ChatJournalColors.black,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                DateFormat('MMM d, y').format(DateTime.now()),
                style: Fonts.drawerFont,
              ),
            ),
          ),
          const ListTile(
            title: Text('Help spread the word'),
            leading: Icon(Icons.card_giftcard),
          ),
          const ListTile(
            title: Text('Search'),
            leading: Icon(Icons.search),
          ),
          const ListTile(
            title: Text('Notifications'),
            leading: Icon(Icons.notifications),
          ),
          const ListTile(
            title: Text('Statistics'),
            leading: Icon(Icons.analytics),
          ),
          const ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          ),
          const ListTile(
            title: Text('Feedback'),
            leading: Icon(Icons.feedback),
          )
        ],
      ),
    );
  }
}
