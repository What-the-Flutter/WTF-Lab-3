import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/locale.dart' as locale;
import '../../../common/widget/confirmation_dialog.dart';
import '../../../common/widget/floating_bottom_sheet.dart';
import '../../../routes.dart';
import '../../locale/locale.dart';
import '../../security/cubit/security_cubit.dart';
import '../../security/security.dart';
import '../../security/widget/verify_method_selector.dart';
import '../../theme/theme.dart';
import '../cubit/settings_cubit.dart';
import '../data/settings_repository_api.dart';
import '../widget/font_size_selector.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.Pages.settings.i18n(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(
              locale.SettingsPage.languageItem.i18n(),
            ),
            onTap: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => const LanguageSelector(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.tag_outlined),
            title: Text(
              locale.SettingsPage.tagItem.i18n(),
            ),
            onTap: () {
              context.go(
                Navigation.manageTagsPagePath,
              );
            },
          ),
          ListTile(
            leading: Icon(
              context.watch<ThemeCubit>().state.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            title: Text(
              locale.SettingsPage.themeItem.i18n(),
            ),
            onTap: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => const ChoiceColorSheet(
                  showExampleMessages: false,
                  showDarkModeButton: true,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: Text(
              locale.SettingsPage.securityItem.i18n(),
            ),
            onTap: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => SecuritySettings(
                  securityRepository: SecurityRepository(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.text_fields_outlined),
            title: Text(
              locale.SettingsPage.fontSizeItem.i18n(),
            ),
            onTap: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => FontSizeSelector(
                  defaultFontSize: context.read<SettingsCubit>().state.fontSize,
                ),
              );
            },
          ),
          SwitchItem(
            title: locale.SettingsPage.bubbleAlignmentItemTitle.i18n(),
            subtitle: locale.SettingsPage.bubbleAlignmentItemSubtitle.i18n(),
            icon: Icons.format_align_left_outlined,
            isToggle: context.watch<SettingsCubit>().state.messageAlignment ==
                MessageAlignment.left,
            onToggle: (isToggle) {
              context.read<SettingsCubit>().changeMessageAlignment(
                    isToggle ? MessageAlignment.left : MessageAlignment.right,
                  );
            },
          ),
          SwitchItem(
            title: locale.SettingsPage.centerDateBubbleItem.i18n(),
            icon: Icons.date_range_outlined,
            isToggle:
                context.watch<SettingsCubit>().state.isCenterDateBubbleShown,
            onToggle: (isToggle) {
              context.read<SettingsCubit>().changeBubbleDateVisibility(
                    isToggle,
                  );
            },
          ),
          ListTile(
            leading: const Icon(Icons.refresh_outlined),
            title: Text(
              locale.SettingsPage.resetItem.i18n(),
            ),
            onTap: () async {
              final isConfirmed = await showConfirmationDialog(
                title: locale.SettingsPage.resetConfirmationTitle.i18n(),
                content: locale.SettingsPage.resetConfirmationSubtitle.i18n(),
                context: context,
              );

              if (isConfirmed != null && isConfirmed) {
                context.read<SettingsCubit>().resetToDefault();
                context.read<SecurityCubit>().resetToDefault();
                context.read<ThemeCubit>().resetToDefault();
                context.read<LocaleCubit>().resetToDefault();
              }
            },
          ),
        ],
      ),
    );
  }
}

class SwitchItem extends StatelessWidget {
  const SwitchItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.isToggle,
    required this.onToggle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final bool isToggle;
  final void Function(bool isToggle) onToggle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: Switch(
        value: isToggle,
        onChanged: onToggle,
      ),
    );
  }
}
