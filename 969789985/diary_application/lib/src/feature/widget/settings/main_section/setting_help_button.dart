import 'package:flutter/material.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/icons.dart';
import '../general/settings_button_foundation.dart';

class SettingsHelpButton extends StatelessWidget {
  const SettingsHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () {},
      iconCodePoint: Icons.integration_instructions_outlined.codePoint,
      buttonTitle: 'Help',
      buttonDescription: 'Application instructions',
      isRemovable: false,
    );
  }
}
