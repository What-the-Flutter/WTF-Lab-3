import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';

class MainScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int index;

  const MainScreenAppBar({
    super.key,
    required this.index,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<MainScreenAppBar> createState() => _MainScreenAppBarState();
}

class _MainScreenAppBarState extends State<MainScreenAppBar> {
  final _listTitle = [
    'Home',
    'Daily',
    'Timeline',
    'Explore',
  ];

  @override
  Widget build(BuildContext context) {
    return widget.index == 2
        ? AppBar(
            title: Text(
              _listTitle[widget.index],
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.headline2!.fontSize,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.turned_in_not),
              ),
            ],
          )
        : AppBar(
            title: Text(
              _listTitle[widget.index],
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.headline2!.fontSize,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.invert_colors),
                onPressed: context.read<SettingCubit>().changeTheme,
              ),
            ],
          );
  }
}
