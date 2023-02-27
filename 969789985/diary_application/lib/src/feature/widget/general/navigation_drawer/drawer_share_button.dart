import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/strings.dart';

class DrawerShareButton extends StatelessWidget {
  const DrawerShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.circle),
        ),
        onPressed: () => _share(context),
        child: Padding(
          padding: const EdgeInsets.only(
            top: Insets.large,
            bottom: Insets.large,
          ),
          child: Row(
            children: const [
              Icon(Icons.share),
              SizedBox(width: Insets.extraLarge),
              Text('Share'),
            ],
          ),
        ),
      ),
    );
  }

  void _share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      Strings.appGitShare,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
