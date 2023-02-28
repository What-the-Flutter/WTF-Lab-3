import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/extension/datetime_extension.dart';
import '../../../cubit/theme/theme_cubit.dart';
import '../../theme/theme_scope.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../theme_switcher.dart';
import 'drawer_notification_button.dart';
import 'drawer_search_button.dart';
import 'drawer_settings_button.dart';
import 'drawer_share_button.dart';

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
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const ThemeSwitcher(),
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
        const DrawerShareButton(),
      ],
    );
  }
}
