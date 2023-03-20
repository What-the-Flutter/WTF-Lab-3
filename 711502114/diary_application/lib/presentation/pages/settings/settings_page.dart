import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/utils/utils.dart';
import 'settings_background_chat_page.dart';
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
    final local = AppLocalizations.of(context)!;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            _listTile(
              local.theme,
              local.themeState,
              Icons.invert_colors,
              onTap: context.read<SettingsCubit>().changeTheme,
            ),
            _listTile(
              local.fingerPrint,
              local.enableFingerPrint,
              Icons.fingerprint,
              trailing: Switch(
                value: state.isLocked,
                onChanged: (_) {
                  context.read<SettingsCubit>().setIsLocked(_);
                },
              ),
            ),
            _listTile(
              local.fontSize,
              local.fontSizeState,
              Icons.format_size,
              onTap: () {
                switch (state.fontSize) {
                  case 0:
                    context.read<SettingsCubit>().changeFontSize(1);
                    break;
                  case 1:
                    context.read<SettingsCubit>().changeFontSize(-1);
                    break;
                  default:
                    context.read<SettingsCubit>().changeFontSize(0);
                    break;
                }
              },
            ),
            _listTile(
              local.bubbleAlignment,
              local.alignmentAction,
              state.alignment
                  ? Icons.format_align_right
                  : Icons.format_align_left,
              trailing: Switch(
                value: state.alignment,
                onChanged: (_) {
                  context.read<SettingsCubit>().setBubbleAlignment(_);
                },
              ),
            ),
            _listTile(
              local.centerDateBubble,
              '',
              Icons.date_range_outlined,
              trailing: Switch(
                value: state.isCenter,
                onChanged: (_) {
                  context.read<SettingsCubit>().setCenterDate(_);
                },
              ),
            ),
            _listTile(
                local.backgroundImage, local.chatBackgroundImage, Icons.image,
                onTap: () {
              openNewPage(context, BackgroundChatImage(state: state));
            }),
            _listTile(
              local.resetSettings,
              local.resetAllSettings,
              Icons.reset_tv,
              onTap: context.read<SettingsCubit>().setDefault,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(
    String title,
    String subtitle,
    IconData icon, {
    void Function()? onTap,
    Widget? trailing,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(icon, size: 30),
          subtitle: Text(subtitle),
          onTap: onTap,
          trailing: trailing,
        ),
      ],
    );
  }
}
