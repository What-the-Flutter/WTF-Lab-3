import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_cubit.dart';
import 'settings_state.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
          ),
          body: _settingsBody(context, state),
        );
      },
    );
  }

  Widget _settingsBody(BuildContext context, SettingsState state) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListView(
        children: [
          _theme(context, state),
          _fingerPrint(context, state),
        ],
      ),
    );
  }

  Widget _theme(BuildContext context, SettingsState state) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Theme',
          ),
          leading: const Icon(
            Icons.invert_colors,
            size: 30,
          ),
          subtitle: Text(
            'Light / Dark',
          ),
          onTap: () {
            context.read<SettingsCubit>().changeTheme();
          },
        ),
      ],
    );
  }

  Widget _fingerPrint(BuildContext context, SettingsState state) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Fingerprint',
          ),
          leading: const Icon(Icons.fingerprint),
          subtitle: Text(
            'Enable Fingerprint unlock',
          ),
          trailing: Switch(
            value: state.isLocked,
            onChanged: (value) {
              context.read<SettingsCubit>().setIsLocked(value);
            },
          ),
        ),
      ],
    );
  }
}
