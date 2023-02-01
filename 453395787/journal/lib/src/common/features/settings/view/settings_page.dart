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
import '../widget/settings/font_size_selector.dart';

part '../widget/settings/chat_settings_item.dart';

part '../widget/settings/manage_tags_item.dart';

part '../widget/settings/manage_languages_item.dart';

part '../widget/settings/manage_security_item.dart';

part '../widget/settings/manage_font_size_item.dart';

part '../widget/settings/share_item.dart';

part '../widget/settings/reset_all_item.dart';


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
        children: const [
          _ChatSettingsItem(),
          _ManageTagsItem(),
          _ManageLanguagesItem(),
          _ManageSecurityItem(),
          _ManageFontSizeItem(),
          _ShareItem(),
          _ResetAllItem(),
        ],
      ),
    );
  }
}
