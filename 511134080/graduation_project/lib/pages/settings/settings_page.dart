import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8,
        ),
        child: ListView(
          children: [
            Text(
              'Visuals',
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 16,
              ),
            ),
            ListTile(
              iconColor: Theme.of(context).disabledColor,
              leading: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.invert_colors,
                ),
              ),
              title: const Text(
                'Theme',
              ),
              subtitle: const Text(
                'Light / Dark',
              ),
              onTap: () {
                context.read<SettingsCubit>().toggleTheme();
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
