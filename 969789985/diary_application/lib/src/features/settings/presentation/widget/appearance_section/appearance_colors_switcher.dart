import 'package:flutter/material.dart';

import '../settings_button_foundation.dart';
import 'colors_bottom_sheet/colors_bottom_sheet.dart';


class AppearanceColorsSwitcher extends StatelessWidget {
  const AppearanceColorsSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () => showModalBottomSheet(
        elevation: 0,
        context: context,
        builder: (context) {
          return const ColorsBottomSheet();
        },
      ),
      iconCodePoint: Icons.colorize.codePoint,
      buttonTitle: 'Main colors',
      buttonDescription: 'Change app colors',
    );
  }
}
