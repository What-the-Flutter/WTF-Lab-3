import 'package:flutter/material.dart';

import '../general/settings_divider.dart';
import 'setting_help_button.dart';
import 'settings_appearance_button.dart';
import 'settings_info_button.dart';
import 'settings_security_button.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SettingsAppearanceButton(),
          const SettingsDivider(),
          const SettingsSecurityButton(),
          const SettingsDivider(),
          const SettingsHelpButton(),
          const SettingsDivider(),
          const SettingsInfoButton(),
          const SettingsDivider(),
        ],
      ),
    );
  }
}
