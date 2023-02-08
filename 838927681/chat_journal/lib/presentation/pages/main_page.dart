import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/provider/theme_provider.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/repository/event_repository.dart';
import '../../theme/colors.dart';
import '../../theme/fonts.dart';
import '../../theme/theme_cubit.dart';
import '../../theme/theme_state.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/theme_button.dart';
import 'chat_page/chat_page_cubit.dart';
import 'create_chat_page/create_chat_cubit.dart';
import 'home_page/home.dart';
import 'home_page/home_page_cubit.dart';

class ChatJournal extends StatelessWidget {
  final title = 'Home';

  const ChatJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepository(),
        ),
        RepositoryProvider<EventRepository>(
          create: (context) => EventRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(themeProvider: ThemeProvider()),
            lazy: false,
          ),
          BlocProvider<ChatCubit>(
            create: (context) => ChatCubit(
              eventRepository: context.read<EventRepository>(),
              chatRepository: context.read<ChatRepository>(),
            ),
          ),
          BlocProvider<CreateChatCubit>(
            create: (context) => CreateChatCubit(
              chatRepository: context.read<ChatRepository>(),
              isCreatingMode: true,
            ),
          ),
          BlocProvider<HomePageCubit>(
            create: (context) => HomePageCubit(
              chatRepository: context.read<ChatRepository>(),
              eventRepository: context.read<EventRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: state.theme,
              home: _mainPage(state, context),
            );
          },
        ),
      ),
    );
  }

  Widget _mainPage(ThemeState state, BuildContext context) {
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
      drawer: _drawer(state, context),
      body: HomePage(themeState: state),
      bottomNavigationBar: const BottomNavigation(),
    );
  }

  Widget _drawer(ThemeState state, BuildContext context) {
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
