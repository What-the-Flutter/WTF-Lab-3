import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/locale.dart' as locale;
import '../../../common/widget/floating_bottom_sheet.dart';
import '../../../routes.dart';
import '../../locale/locale.dart';

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
        ],
      ),
    );
  }
}
