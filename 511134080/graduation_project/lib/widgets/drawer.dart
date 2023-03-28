import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../pages/home/home_cubit.dart';
import '../pages/settings/settings_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Widget _drawerHeader(BuildContext context) => DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            DateFormat('MMM dd, yyyy').format(
              DateTime.now(),
            ),
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
          ),
        ),
      );

  Widget _drawerSpreadingTile(BuildContext context) => ListTile(
        onTap: () {
          context.read<HomeCubit>().share();
        },
        iconColor: Theme.of(context).disabledColor,
        leading: const Icon(
          Icons.redeem,
        ),
        title: Text(
          'Help spread the word',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).disabledColor,
              ),
        ),
      );

  Widget _drawerSettingTile(BuildContext context) => ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            ),
          );
        },
        iconColor: Theme.of(context).disabledColor,
        leading: const Icon(
          Icons.settings,
        ),
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).disabledColor,
              ),
        ),
      );

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _drawerHeader(context),
            _drawerSpreadingTile(context),
            _drawerSettingTile(context),
          ],
        ),
      );
}
