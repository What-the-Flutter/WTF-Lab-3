import 'package:flutter/material.dart';

import '../../pages/appearance_page.dart';
import '../settings_button_foundation.dart';

class SettingsAppearanceButton extends StatelessWidget {
  const SettingsAppearanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AppearancePage(),
        ),
      ),
      iconCodePoint: Icons.color_lens_outlined.codePoint,
      buttonTitle: 'Appearance',
      buttonDescription: 'Change the App\'s Appearance',
    );
  }
}
