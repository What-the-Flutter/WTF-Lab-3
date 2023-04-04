import 'package:diary_application/domain/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_background_chat_page.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';

enum FontSize { small, medium, big }

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
              context,
              local.theme,
              local.themeState,
              Icons.invert_colors,
              onTap: context.read<SettingsCubit>().changeTheme,
            ),
            _listTile(
              context,
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
              context,
              local.fontSize,
              local.fontSizeState,
              Icons.format_size,
              onTap: () {
                final String font;
                if (FontSize.medium.toString() == state.fontSize) {
                  font = FontSize.big.toString();
                } else if (FontSize.big.toString() == state.fontSize) {
                  font = FontSize.small.toString();
                } else {
                  font = FontSize.medium.toString();
                }
                context.read<SettingsCubit>().setFontSize(font);
              },
            ),
            _listTile(
              context,
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
              context,
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
            _listTile(context, local.backgroundImage, local.chatBackgroundImage,
                Icons.image, onTap: () {
              openNewPage(context, const BackgroundChatImage());
            }),
            _listTile(
              context,
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
    BuildContext context,
    String title,
    String subtitle,
    IconData icon, {
    void Function()? onTap,
    Widget? trailing,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: textTheme(context).bodyText2!),
          leading: Icon(icon, size: 30),
          subtitle: Text(subtitle, style: textTheme(context).bodyText1!),
          onTap: onTap,
          trailing: trailing,
        ),
      ],
    );
  }
}
