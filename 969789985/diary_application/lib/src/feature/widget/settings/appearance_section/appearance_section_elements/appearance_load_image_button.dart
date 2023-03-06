import 'package:flutter/material.dart';

import '../../general/settings_button_foundation.dart';
import '../chat_background/background_selector_sheet.dart';

class AppearanceLoadImageButton extends StatelessWidget {
  const AppearanceLoadImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () => _showBottomBottomSheetSelector(context),
      iconCodePoint: Icons.imagesearch_roller_outlined.codePoint,
      buttonTitle: 'Chat background',
      buttonDescription: 'Change background in chat',
      isRemovable: false,
    );
  }

  void _showBottomBottomSheetSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      barrierColor: Colors.transparent,
      builder: (context) => BackgroundSelectorSheet(bContext: context),
    );
  }
}
