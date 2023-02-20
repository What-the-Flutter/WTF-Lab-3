import 'package:flutter/material.dart';

import '../../../../core/util/resources/icons.dart';
import '../general/settings_button_foundation.dart';

class SettingsInfoButton extends StatelessWidget {
  const SettingsInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () {},
      iconCodePoint: Icons.info_outline_rounded.codePoint,
      buttonTitle: 'Info',
      buttonDescription: 'Any other information',
    );
  }
}
