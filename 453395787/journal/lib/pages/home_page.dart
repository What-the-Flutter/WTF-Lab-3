import 'package:flutter/material.dart';

import '../utils/styles.dart';
import '../utils/theme.dart';
import 'all_chats/add_chat_page.dart';
import 'all_chats/bottom_action_sheet.dart';
import 'all_chats/chat_list.dart';
import 'choose_color_page.dart';
import 'empty_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  final List<Widget> _pages = [
    ChatList(),
    const EmptyPage(),
    const EmptyPage(),
    const EmptyPage(),
  ];

  final List<Widget> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.view_day_outlined),
      label: 'Daily',
    ),
    NavigationDestination(
      icon: Icon(Icons.timeline),
      label: 'Timeline',
    ),
    NavigationDestination(
      icon: Icon(Icons.explore),
      label: 'Explore',
    ),
  ];

  void _onBottomNavigationTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  Widget? _floatingActionButton(BuildContext context) {
    if (_selectedPage == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const AddChatPage();
            }),
          );
        },
        child: const Icon(Icons.add),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = ThemeChanger.of(context).appTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (_destinations[_selectedPage] as NavigationDestination).label,
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(
              Radius.extraLarge,
            ),
            onTap: () {
              appTheme.toggleThemeMode();
            },
            onLongPress: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => ChooseColorSheet(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: Icon(
                appTheme.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
          ),
        ],
      ),
      body: _pages[_selectedPage],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onBottomNavigationTap,
        selectedIndex: _selectedPage,
        destinations: _destinations,
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }
}
