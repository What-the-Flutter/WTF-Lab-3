import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../features/locale/locale.dart';
import '../../../../features/security/security.dart';
import '../../../../routes.dart';
import '../../../utils/locale.dart' as locale;
import '../../../widget/confirmation_dialog.dart';
import '../../theme/theme.dart';
import '../cubit/settings_cubit.dart';
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
            leading: const Icon(Icons.chat_outlined),
            title: Text(
              locale.SettingsPage.chatItem.i18n(),
            ),
            onTap: () async {
              context.go(Navigation.chatSettingsPagePath);
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
            leading: const Icon(Icons.language_outlined),
            title: Text(
              locale.SettingsPage.languageItem.i18n(),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const LanguageSelector(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: Text(
              locale.SettingsPage.securityItem.i18n(),
            ),
            onTap: () {
              showModalBottomSheet(
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
              showModalBottomSheet(
                context: context,
                builder: (context) => const FontSizeSelector(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: Text(
              locale.SettingsPage.shareItem.i18n(),
            ),
            onTap: () async {
              await Share.share(
                locale.SettingsPage.shareAppText.i18n(),
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
