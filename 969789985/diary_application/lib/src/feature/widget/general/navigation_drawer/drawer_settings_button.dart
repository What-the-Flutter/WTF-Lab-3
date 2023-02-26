import 'package:flutter/material.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../page/settings/settings_page.dart';

class DrawerSettingsButton extends StatelessWidget {
  const DrawerSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.circle),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: Insets.large,
            bottom: Insets.large,
          ),
          child: Row(
            children: const [
              Icon(Icons.settings),
              SizedBox(width: Insets.extraLarge),
              Text('Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
