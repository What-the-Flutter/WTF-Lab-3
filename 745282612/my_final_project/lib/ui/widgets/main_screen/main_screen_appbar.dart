import 'package:flutter/material.dart';

import '../../../my_chat_app.dart';

class MainScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainScreenAppBar({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  State<MainScreenAppBar> createState() => _MainScreenAppBarState();
}

class _MainScreenAppBarState extends State<MainScreenAppBar> {
  bool _themeStatus = true;
  final _listTitle = [
    'Home',
    'Daily',
    'Timeline',
    'Explore',
  ];
  void onInvertColors() {
    setState(
      () {
        _themeStatus = !_themeStatus;
        _themeStatus
            ? MainApp.of(context).changeTheme(ThemeMode.light)
            : MainApp.of(context).changeTheme(ThemeMode.dark);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_listTitle[widget.index]),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: _themeStatus
              ? const Icon(Icons.invert_colors)
              : const Icon(Icons.invert_colors_off),
          onPressed: onInvertColors,
        ),
      ],
    );
  }
}
