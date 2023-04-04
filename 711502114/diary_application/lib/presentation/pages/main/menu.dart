import 'package:diary_application/presentation/pages/daily/daily_page.dart';
import 'package:diary_application/presentation/pages/explore/explore_page.dart';
import 'package:diary_application/presentation/pages/home/home_page.dart';
import 'package:diary_application/presentation/pages/timeline/timeline_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

        return Scaffold(
          body: Center(
            child: cubit.isAuthenticated
                ? _pages[pageState.pageIndex]
                : _showWaitLabel(local, cubit.tryingUnlock),
          ),
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

  Widget _showWaitLabel(AppLocalizations? local, bool tryToUnlock) {
    return Text(tryToUnlock ? local?.wait ?? '' : local?.notAuth ?? '');
  }
}
