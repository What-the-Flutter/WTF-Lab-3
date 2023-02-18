import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubit/menu/menu_cubit.dart';
import 'daily_page.dart';
import 'explore_page.dart';
import 'home_page.dart';
import 'timeline_page.dart';

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
    return BlocBuilder<MenuCubit, int>(
      builder: (context, pageState) {
        final local = AppLocalizations.of(context);
        final choosePage = context.read<MenuCubit>().choosePage;
        return Scaffold(
          body: Center(child: _pages[pageState]),
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
            currentIndex: pageState,
            onTap: choosePage,
          ),
        );
      },
    );
  }
}
