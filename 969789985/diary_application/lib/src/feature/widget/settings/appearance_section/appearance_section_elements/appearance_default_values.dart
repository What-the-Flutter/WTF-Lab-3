import 'package:flutter/material.dart';

import '../../../general/custom_dialog.dart';
import '../../../theme/theme_scope.dart';
import '../../general/settings_button_foundation.dart';

class AppearanceDefaultValues extends StatelessWidget {
  const AppearanceDefaultValues({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              cancelVisible: true,
              dialogTitle: 'Reset settings',
              dialogDescription: const Text(
                'After clicking OK, all settings will accept the default settings.',
              ),
              completeAction: () => ThemeScope.of(context).resetSettings(),
            );
          },
        );
      },
      iconCodePoint: Icons.disabled_by_default_outlined.codePoint,
      buttonTitle: 'Reset settings',
      buttonDescription: 'Settings will become default',
      isRemovable: true,
    );
  }
}
