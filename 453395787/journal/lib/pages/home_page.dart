import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../src/common/utils/floating_bottom_sheet.dart';
import '../src/common/utils/insets.dart';
import '../src/common/utils/radius.dart';
import '../src/features/chat_adding_editing/view/manage_chat_page.dart';
import '../src/features/chats_overview/view/chat_list.dart';
import '../src/features/empty_page/empty_page.dart';
import '../src/features/navigation/cubit/navigation_cubit.dart';
import '../src/features/theme/cubit/theme_cubit.dart';
import '../src/features/theme/widget/choose_color_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  static const routeName = '/';

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
              return const ManageChatPage();
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
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        state.map(
          goTo: (goTo) {
            context.go(goTo.route);
          },
          back: (back) {
            context.pop();
          },
        );
      },
      child: Scaffold(
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
                context.read<ThemeCubit>().toggleDarkMode();
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
                  context.watch<ThemeCubit>().state.isDarkMode
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
      ),
    );
  }
}
