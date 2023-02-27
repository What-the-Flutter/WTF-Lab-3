import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../theme/theme_scope.dart';

class BackgroundColorPicker extends StatefulWidget {
  const BackgroundColorPicker({super.key});

  @override
  State<BackgroundColorPicker> createState() => _BackgroundColorPickerState();
}

class _BackgroundColorPickerState extends State<BackgroundColorPicker> {
  late int _chatBackgroundColor;

  @override
  void initState() {
    super.initState();

    _chatBackgroundColor = ThemeScope.of(context).state.chatBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: MediaQuery.of(context).orientation == Orientation.portrait
            ? const BorderRadius.vertical(
          top: Radius.circular(500),
          bottom: Radius.circular(100),
        )
            : const BorderRadius.horizontal(
          right: Radius.circular(500),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            HueRingPicker(
              pickerColor: Colors.red,
              onColorChanged: (value) {
                _chatBackgroundColor = value.value;
              },
              enableAlpha: false,
              displayThumbColor: true,
            ),
            const SizedBox(height: Insets.large),
            Row(
              children: [
                const SizedBox(width: Insets.large),
                Padding(
                  padding: const EdgeInsets.only(bottom: Insets.medium),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Radii.circle),
                    ),
                    onPressed: () {
                      ThemeScope.of(context).chatBackgroundColor =
                          Theme.of(context).scaffoldBackgroundColor.value;
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Insets.large,
                      ),
                      child: Text('Default'),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: Insets.medium),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Radii.circle),
                    ),
                    onPressed: () {
                      ThemeScope.of(context).chatBackgroundColor =
                          _chatBackgroundColor;
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Insets.large,
                      ),
                      child: Text('Select'),
                    ),
                  ),
                ),
                const SizedBox(width: Insets.large),
              ],
            ),
          ],
        ),
      ),
    );
  }
}