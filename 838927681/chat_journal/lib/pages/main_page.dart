import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';
import '../theme/fonts.dart';
import '../theme/theme_cubit.dart';
import '../theme/theme_state.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/theme_button.dart';
import 'home_page/home.dart';

class ChatJournal extends StatefulWidget {
  const ChatJournal({super.key});

  final title = 'Home';

  @override
  State<ChatJournal> createState() => _ChatJournalState();
}

class _ChatJournalState extends State<ChatJournal> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = ThemeCubit();
    return BlocProvider<ThemeCubit>(
      create: (context) => themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          {
            return MaterialApp(
              theme: state.theme,
              home: _mainPage(context),
            );
          }
        },
      ),
    );
  }

  Widget _mainPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
        actions: const [
          ThemeButton(),
        ],
      ),
      drawer: _drawer(context),
      body: HomePage(),
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
