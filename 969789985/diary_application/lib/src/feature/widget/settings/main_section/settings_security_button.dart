import 'package:flutter/material.dart';

import '../../../page/settings/security/security_page.dart';
import '../general/settings_button_foundation.dart';

class SettingsSecurityButton extends StatelessWidget {
  const SettingsSecurityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SecurityPage(),
        ),
      ),
      iconCodePoint: Icons.lock_outline.codePoint,
      buttonTitle: 'Security',
      buttonDescription: 'Protect your information',
    );
  }
}
