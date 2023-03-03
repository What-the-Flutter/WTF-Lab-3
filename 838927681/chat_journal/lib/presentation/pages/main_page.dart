import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../theme/colors.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/theme_button.dart';
import 'home_page/home.dart';
import 'main_page/app_cubit.dart';
import 'main_page/app_state.dart';
import 'settings_page/settings.dart';
import 'settings_page/settings_cubit.dart';
import 'settings_page/settings_state.dart';

class ChatJournal extends StatelessWidget {
  final SettingsState settingsState;
  final AppState appState;
  final title = 'Home';

  ChatJournal({required this.settingsState, super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return _mainPage(context);
  }

  Widget _mainPage(BuildContext context) {
    final isAuthenticated = appState.isAuthenticated;
    if (isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: settingsState.fontSize.headline1!,
          ),
          centerTitle: true,
          actions: const [
            ThemeButton(),
          ],
        ),
        drawer: _drawer(settingsState, context),
        body: HomePage(
          settingsState: settingsState,
        ),
        bottomNavigationBar: const BottomNavigation(),
      );
    } else {
      if (appState.tryingUnlock) {
        return (_waitingToUnlock(context));
      } else {
        return _notAuthenticated(context);
      }
    }
  }

  Widget _waitingToUnlock(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Journal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please wait'),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _notAuthenticated(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please try again'),
            TextButton(
              onPressed: () async {
                await BlocProvider.of<AppCubit>(context).authenticate();
              },
              child: const Text('try again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawer(SettingsState state, BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: BlocProvider.of<SettingsCubit>(context).isLight()
                  ? ChatJournalColors.green
                  : ChatJournalColors.black,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                DateFormat('MMM d, y').format(DateTime.now()),
                style: settingsState.fontSize.headline2!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Help spread the word',
              style: settingsState.fontSize.bodyText1!,
            ),
            leading: const Icon(Icons.card_giftcard),
            onTap: () async {
              await Share.share(
                  'Keep track of your life with Chat Journal, a simple and elegant '
                  'chat-based journal/notes application that makes journaling/note-taking fun,'
                  'easy, quick and effortless.'
                  ''
                  'https://play.google.com/store/apps/details?id=com.'
                  'agiletelescope.chatjournal');
            },
          ),
          ListTile(
            title: Text('Search', style: settingsState.fontSize.bodyText1!),
            leading: const Icon(Icons.search),
          ),
          ListTile(
            title:
                Text('Notifications', style: settingsState.fontSize.bodyText1!),
            leading: const Icon(Icons.notifications),
          ),
          ListTile(
            title: Text('Statistics', style: settingsState.fontSize.bodyText1!),
            leading: const Icon(Icons.analytics),
          ),
          ListTile(
            title: Text('Settings', style: settingsState.fontSize.bodyText1!),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Feedback', style: settingsState.fontSize.bodyText1!),
            leading: const Icon(Icons.feedback),
          )
        ],
      ),
    );
  }
}
