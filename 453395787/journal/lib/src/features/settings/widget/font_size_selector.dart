import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../cubit/settings_cubit.dart';
import '../data/settings_repository_api.dart';

class FontSizeSelector extends StatefulWidget {
  const FontSizeSelector({
    super.key,
    required this.defaultFontSize,
  });

  final FontSize defaultFontSize;

  @override
  State<FontSizeSelector> createState() => _FontSizeSelectorState();
}

class _FontSizeSelectorState extends State<FontSizeSelector> {
  late FontSize _fontSize;

  @override
  void initState() {
    _fontSize = widget.defaultFontSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.medium,
        vertical: Insets.large,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text(
              locale.SettingsPage.fontSizeSmall.i18n(),
            ),
            value: _fontSize == FontSize.small,
            onChanged: (isChecked) async {
              context.read<SettingsCubit>().changeFontSize(FontSize.small);
              setState(() {
                _fontSize = FontSize.small;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              locale.SettingsPage.fontSizeMedium.i18n(),
            ),
            value: _fontSize == FontSize.medium,
            onChanged: (isChecked) async {
              context.read<SettingsCubit>().changeFontSize(FontSize.medium);
              setState(() {
                _fontSize = FontSize.medium;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              locale.SettingsPage.fontSizeLarge.i18n(),
            ),
            value: _fontSize == FontSize.large,
            onChanged: (isChecked) async {
              context.read<SettingsCubit>().changeFontSize(FontSize.large);
              setState(() {
                _fontSize = FontSize.large;
              });
            },
          ),
        ],
      ),
    );
  }
}
