import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../theme/colors.dart';
import '../../theme/fonts.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/theme_button.dart';
import 'home_page/home.dart';
import 'main_page/app_cubit.dart';
import 'settings_page/settings.dart';
import 'settings_page/settings_cubit.dart';
import 'settings_page/settings_state.dart';

class ChatJournal extends StatelessWidget {
  final SettingsState state;
  final title = 'Home';

  ChatJournal({required this.state, super.key}) {
    //_init();
  }

  @override
  Widget build(BuildContext context) {
    return _mainPage(context);
  }

  Widget _mainPage(BuildContext context) {
    final isAuthenticated = BlocProvider.of<AppCubit>(context).isAuthenticated;
    if (isAuthenticated) {
      return Builder(
        builder: (context) {
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
            body: HomePage(
              settingsState: state,
            ),
            bottomNavigationBar: const BottomNavigation(),
          );
        },
      );
    } else {
      return _notAuthenticated(context);
    }
  }

  Widget _notAuthenticated(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
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
