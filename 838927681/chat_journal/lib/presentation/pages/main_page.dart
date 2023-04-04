import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../theme/colors.dart';
import '../../theme/themes.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/theme_button.dart';
import 'home_page/home.dart';
import 'main_page/app_cubit.dart';
import 'main_page/app_state.dart';
import 'settings_page/settings.dart';
import 'settings_page/settings_cubit.dart';
import 'settings_page/settings_state.dart';
import 'statistics/statistics.dart';
import 'timeline_page/timeline_page.dart';

class ChatJournal extends StatelessWidget {
  final SettingsState settingsState;
  final AppState appState;

  ChatJournal({required this.settingsState, super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return _mainPage(context);
  }

  TextTheme textTheme(BuildContext context) {
    final fontSize = context.read<SettingsCubit>().state.fontSize;
    switch (fontSize) {
      case 1:
        return Themes.largeTextTheme;
      case -1:
        return Themes.smallTextTheme;
      default:
        return Themes.normalTextTheme;
    }
  }

  Widget _mainPage(BuildContext context) {
    final appState = context.watch<AppCubit>().state;
    final isAuthenticated = appState.isAuthenticated;
    if (isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            appState.title,
            style: textTheme(context).headline1!,
          ),
          centerTitle: true,
          actions: const [
            ThemeButton(),
          ],
        ),
        drawer: _drawer(settingsState, context),
        body: _currentPage(context),
        bottomNavigationBar:
            BottomNavigation(onTap: context.read<AppCubit>().changePageIndex),
      );
    } else {
      if (appState.tryingUnlock) {
        return (_waitingToUnlock(context));
      } else {
        return _notAuthenticated(context);
      }
    }
  }

  Widget _currentPage(BuildContext context) {
    final homeTitle = 'Home';
    final timelineTitle = 'Timeline';
    switch (context.watch<AppCubit>().state.pageIndex) {
      case 0:
        {
          context.read<AppCubit>().changeTitle(homeTitle);
          return HomePage();
        }
      case 2:
        {
          context.read<AppCubit>().changeTitle(timelineTitle);
          return TimelinePage();
        }
      default:
        {
          context.read<AppCubit>().changeTitle(homeTitle);
          return HomePage();
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
              color: context.watch<SettingsCubit>().state.isLightTheme
                  ? ChatJournalColors.green
                  : ChatJournalColors.black,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                DateFormat('MMM d, y').format(DateTime.now()),
                style: textTheme(context).headline2!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Help spread the word',
              style: textTheme(context).bodyText1!,
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
            title: Text('Search', style: textTheme(context).bodyText1!),
            leading: const Icon(Icons.search),
          ),
          ListTile(
            title: Text('Notifications', style: textTheme(context).bodyText1!),
            leading: const Icon(Icons.notifications),
          ),
          ListTile(
            title: Text('Statistics', style: textTheme(context).bodyText1!),
            leading: const Icon(Icons.analytics),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Statistics(),
              ),
            ),
          ),
          ListTile(
            title: Text('Settings', style: textTheme(context).bodyText1!),
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
            title: Text('Feedback', style: textTheme(context).bodyText1!),
            leading: const Icon(Icons.feedback),
          )
        ],
      ),
    );
  }
}
