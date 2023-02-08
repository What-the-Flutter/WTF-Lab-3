import 'package:flutter/material.dart';

import '../settings_button_foundation.dart';

class SettingsSecurityButton extends StatelessWidget {
  const SettingsSecurityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () {},
      iconCodePoint: Icons.lock_outline.codePoint,
      buttonTitle: 'Security',
      buttonDescription: 'Protect your information',
    );
  }
}
