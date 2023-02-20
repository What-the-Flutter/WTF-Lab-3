import 'package:flutter/material.dart';

import '../../../page/settings/security/passcode_warning_page.dart';
import '../general/settings_button_foundation.dart';

class SecurityPasscodeButton extends StatelessWidget {
  const SecurityPasscodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasscodeWarningPage(),
        ),
      ),
      buttonTitle: 'Passcode',
      buttonDescription: 'Set a login passcode',
      iconCodePoint: Icons.key.codePoint,
    );
  }
}
