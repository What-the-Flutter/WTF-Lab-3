import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../utils/insets.dart';
import '../../../utils/locale.dart' as locale;
import '../cubit/settings_cubit.dart';
import '../data/settings_repository_api.dart';

class FontSizeSelector extends StatelessWidget {
  const FontSizeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.medium,
        vertical: Insets.large,
      ),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: Text(
                  locale.SettingsPage.fontSizeSmall.i18n(),
                ),
                value: state.fontSize == FontSize.small,
                onChanged: (isChecked) async {
                  context.read<SettingsCubit>().changeFontSize(FontSize.small);
                },
              ),
              CheckboxListTile(
                title: Text(
                  locale.SettingsPage.fontSizeMedium.i18n(),
                ),
                value: state.fontSize == FontSize.medium,
                onChanged: (isChecked) async {
                  context.read<SettingsCubit>().changeFontSize(FontSize.medium);
                },
              ),
              CheckboxListTile(
                title: Text(
                  locale.SettingsPage.fontSizeLarge.i18n(),
                ),
                value: state.fontSize == FontSize.large,
                onChanged: (isChecked) async {
                  context.read<SettingsCubit>().changeFontSize(FontSize.large);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
