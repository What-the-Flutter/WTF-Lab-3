import 'package:flutter/material.dart';

import '../../../../../common/values/dimensions.dart';
import '../settings_divider.dart';
import 'appearance_color_example.dart';
import 'appearance_colors_switcher.dart';
import 'appearance_font_size_switcher.dart';
import 'appearance_message_example.dart';
import 'appearance_tag_add.dart';

class AppearanceBody extends StatelessWidget {
  const AppearanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        const AppearanceFontSizeSwitcher(),
        const SizedBox(height: Insets.medium),
        const AppearanceMessageExample(message: 'Hello! ☺'),
        const SizedBox(height: Insets.small),
        const AppearanceMessageExample(
          message:
              'We hope you are in a great mood today, because it is important for us!',
        ),
        const SettingsDivider(),
        Row(
          children: [
            const Expanded(
              child: AppearanceColorsSwitcher(),
            ),
            const Padding(
              padding: EdgeInsets.only(right: Insets.appConstantExtraLarge),
              child: AppearanceColorExample(),
            ),
          ],
        ),
        const SettingsDivider(),
        const AppearanceTagAdd(),
        const SettingsDivider(),
      ],
    );
  }
}
