import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/app_theme/app_theme_cubit.dart';
import '../widgets/daily.dart';
import '../widgets/explore.dart';
import '../widgets/time_line.dart';
import 'home/home.dart';
import 'settings/settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final _screens = [
    Home(),
    Daily(),
    TimeLine(),
    Explore(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReadContext(context)
          .read<AppThemeCubit>()
          .state
          .customTheme
          .backgroundColor,
      appBar: _appBar(),
      body: SizedBox.expand(
        child: Container(
          child: _screens[_index],
          color: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .backgroundColor,
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      drawer: _drawer(),
    );
  }

  Widget _drawer() {
    return Drawer(
      backgroundColor: ReadContext(context)
          .read<AppThemeCubit>()
          .state
          .customTheme
          .auxiliaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .themeColor,
            ),
            child: Text(
              'Chat Journal',
              style: TextStyle(
                  color: ReadContext(context)
                      .read<AppThemeCubit>()
                      .state
                      .customTheme
                      .textColor),
            ),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                  color: ReadContext(context)
                      .read<AppThemeCubit>()
                      .state
                      .customTheme
                      .textColor),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Share',
              style: TextStyle(
                  color: ReadContext(context)
                      .read<AppThemeCubit>()
                      .state
                      .customTheme
                      .textColor),
            ),
            onTap: () {
              Share.share(
                'Chat journal!',
                subject: 'Download the App',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _index,
      selectedItemColor: ReadContext(context)
          .read<AppThemeCubit>()
          .state
          .customTheme
          .iconColor,
      unselectedItemColor: ReadContext(context)
          .read<AppThemeCubit>()
          .state
          .customTheme
          .iconColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.home,
          ),
          backgroundColor: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .backgroundColor,
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: const Icon(
              Icons.assignment,
            ),
            backgroundColor: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .backgroundColor,
            label: 'Daily'),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.timeline,
          ),
          backgroundColor: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .backgroundColor,
          label: 'TimeLine',
        ),
        BottomNavigationBarItem(
            icon: const Icon(
              Icons.explore,
            ),
            backgroundColor: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .backgroundColor,
            label: 'Explore'),
      ],
      onTap: (index) {
        setState(() => _index = index);
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: ReadContext(context)
          .read<AppThemeCubit>()
          .state
          .customTheme
          .themeColor,
      iconTheme: IconThemeData(
        color: ReadContext(context)
            .read<AppThemeCubit>()
            .state
            .customTheme
            .keyColor,
      ),
      title: Center(
        child: Text(
          _screens[_index].title,
          style: TextStyle(
            color: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .keyColor,
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            child: Icon(
              Icons.contrast,
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .keyColor,
            ),
            onTap: () {
              setState(() {
                ReadContext(context).read<AppThemeCubit>().changeTheme();
              });
            },
          ),
        )
      ],
    );
  }
}
