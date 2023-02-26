import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/fonts.dart';
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: _settingsBody(context, state),
        );
      },
    );
  }

  Widget _settingsBody(BuildContext context, SettingsState state) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visuals',
            style: Fonts.chatMenuFont,
          ),
          Expanded(child: _visualsBody(context, state)),
        ],
      ),
    );
  }

  Widget _visualsBody(BuildContext context, SettingsState state) {
    return ListView(
      children: [
        _divider(),
        ListTile(
          title: const Text('Theme'),
          leading: const Icon(
            Icons.invert_colors,
            size: 30,
          ),
          subtitle: const Text('Light / Dark'),
          onTap: () {
            context.read<SettingsCubit>().changeTheme();
          },
        ),
        _divider(),
        Row(
          children: [
            const Flexible(
              child: ListTile(
                title: Text('Fingerprint'),
                leading: Icon(Icons.fingerprint),
                subtitle: Text('Enable Fingerprint unlock'),
              ),
            ),
            Switch(
              value: state.isLocked,
              onChanged: (value) {
                context.read<SettingsCubit>().setIsLocked(value);
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      thickness: 2,
    );
  }
}
