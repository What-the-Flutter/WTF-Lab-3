import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_cubit.dart';
import 'settings_state.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.settings ?? ''),
        centerTitle: true,
      ),
      body: _settingsBody(context),
    );
  }

  Widget _settingsBody(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            _theme(context, state, local),
            _fingerPrint(context, state, local),
          ],
        ),
      ),
    );
  }

  Widget _theme(
      BuildContext context, SettingsState state, AppLocalizations? local) {
    return Column(
      children: [
        ListTile(
          title: Text(local?.theme ?? ''),
          leading: const Icon(
            Icons.invert_colors,
            size: 30,
          ),
          subtitle: Text(local?.themeState ?? ''),
          onTap: () {
            context.read<SettingsCubit>().changeTheme();
          },
        ),
      ],
    );
  }

  Widget _fingerPrint(
      BuildContext context, SettingsState state, AppLocalizations? local) {
    return Column(
      children: [
        ListTile(
          title: Text(local?.fingerPrint ?? ''),
          leading: const Icon(Icons.fingerprint),
          subtitle: Text(local?.enableFingerPrint ?? ''),
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
