import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/locale.dart' as locale;
import '../../../common/widget/floating_bottom_sheet.dart';
import '../../../routes.dart';
import '../../locale/locale.dart';
import '../../security/security.dart';
import '../../security/widget/verify_method_selector.dart';
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
        ],
      ),
    );
  }
}
