import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';

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
  String title(int index) {
    late final String title;
    switch (index) {
      case 0:
        title = S.of(context).home_title;
        break;
      case 1:
        title = S.of(context).daily_title;
        break;
      case 2:
        title = S.of(context).timeline_title;
        break;
      case 3:
        title = S.of(context).explore_title;
        break;
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title(widget.index),
        style: TextStyle(
          fontSize: context.watch<SettingCubit>().state.textTheme.headline2!.fontSize,
        ),
      ),
      actions: [
        IconButton(
          onPressed: widget.index == 2
              ? context.read<TimelineCubit>().changeFavoriteStatus
              : context.read<SettingCubit>().changeTheme,
          icon: Icon(
            widget.index == 2
                ? context.watch<TimelineCubit>().state.isFavorite
                    ? Icons.turned_in
                    : Icons.turned_in_not
                : Icons.invert_colors,
          ),
        ),
      ],
    );
  }
}
