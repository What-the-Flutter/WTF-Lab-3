import 'package:flutter/material.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../general/settings_divider.dart';
import 'appearance_section_elements/appearance_color_example.dart';
import 'appearance_section_elements/appearance_colors_switcher.dart';
import 'appearance_section_elements/appearance_default_values.dart';
import 'appearance_section_elements/appearance_font_size_switcher.dart';
import 'appearance_section_elements/appearance_group_header_switcher.dart';
import 'appearance_section_elements/appearance_load_image_button.dart';
import 'appearance_section_elements/appearance_message_alignment.dart';
import 'appearance_section_elements/appearance_message_example.dart';
import 'appearance_section_elements/appearance_radius_switcher.dart';
import 'appearance_section_elements/appearance_tag_add.dart';

class AppearanceBody extends StatelessWidget {
  const AppearanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        const SizedBox(height: Insets.medium),
        const AppearanceFontSizeSwitcher(),
        const SizedBox(height: Insets.medium),
        const AppearanceMessageExample(),
        const SizedBox(height: Insets.medium),
        const AppearanceMessageAlignment(),
        const SizedBox(height: Insets.medium),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.appConstantLarge * 1.2,
          ),
          child: Row(
            children: [
              const Text(
                'Date bubble',
                style: TextStyle(fontSize: FontsSize.large),
              ),
              const SizedBox(width: Insets.medium),
              const AppearanceGroupHeaderSwitcher(),
            ],
          ),
        ),
        const SizedBox(height: Insets.medium),
        const AppearanceRadiusSwitcher(),
        const SizedBox(height: Insets.medium),
        const AppearanceLoadImageButton(),
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
        const AppearanceDefaultValues(),
        const SettingsDivider(),
      ],
    );
  }
}
