import 'package:flutter/material.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../../../common/values/icons.dart';
import '../settings_button_foundation.dart';

class SettingsHelpButton extends StatelessWidget {
  const SettingsHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () {},
      iconCodePoint: Icons.integration_instructions_outlined.codePoint,
      buttonTitle: 'Help',
      buttonDescription: 'Application instructions',
    );
  }
}
