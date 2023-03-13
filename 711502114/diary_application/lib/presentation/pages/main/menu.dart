import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../daily/daily_page.dart';
import '../explore/explore_page.dart';
import '../home/home_page.dart';
import '../timeline/timeline_page.dart';
import 'menu_cubit.dart';
import 'menu_state.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    DailyPage(),
    TimelinePage(),
    ExplorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, pageState) {
        final local = AppLocalizations.of(context);
        final cubit = context.read<MenuCubit>();
        final choosePage = cubit.choosePage;

        if (!cubit.isAuthenticated) {
          if (cubit.tryingUnlock) {
            return const Text('Wait...');
          } else {
            const Text('Not authenticated!');
          }
        }

        return Scaffold(
          body: Center(child: _pages[pageState.pageIndex]),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.book),
                label: local?.homePage,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.assignment),
                label: local?.dailyPage,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.map),
                label: local?.timelinePage,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.explore),
                label: local?.explorePage,
              ),
            ],
            currentIndex: pageState.pageIndex,
            onTap: choosePage,
          ),
        );
      },
    );
  }
}
