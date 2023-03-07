import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/util/resources/strings.dart';
import '../general/settings_button_foundation.dart';

class SettingsShareButton extends StatelessWidget {
  const SettingsShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () async {
        final box = context.findRenderObject() as RenderBox?;

        await Share.share(
          Strings.appGitShare,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      },
      iconCodePoint: Icons.share.codePoint,
      buttonTitle: 'Share',
      buttonDescription: 'Please share the app ☺',
      isRemovable: false,
    );
  }
}
