import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/datetime_extension.dart';
import '../../themes/cubit/theme_cubit.dart';
import '../../themes/widget/theme_scope.dart';
import '../../values/dimensions.dart';
import '../theme_switcher.dart';
import 'drawer_notification_button.dart';
import 'drawer_search_button.dart';
import 'drawer_settings_button.dart';

class NavigationDrawerMenu extends StatelessWidget {
  const NavigationDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: Color(context.watch<ThemeCubit>().state.primaryItemColor),
      elevation: 0,
      children: [
        const SizedBox(height: Insets.extraLarge),
        Padding(
          padding: const EdgeInsets.only(
            left: Insets.large,
            right: Insets.small,
          ),
          child: Row(
            children: [
              const Text(
                'Diary',
                style: TextStyle(
                  fontSize: FontsSize.extraLarge,
                ),
              ),
              const Spacer(),
              ThemeSwitcher(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            Insets.large,
          ),
          child: Text(
            'Today ${DateTime.now().dateYMMMDFormat()}',
            style: const TextStyle(
              fontSize: FontsSize.normal,
            ),
          ),
        ),
        const DrawerSearchButton(),
        const DrawerNotificationButton(),
        const DrawerSettingsButton(),
      ],
    );
  }
}
