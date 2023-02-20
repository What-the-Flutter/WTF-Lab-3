import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/strings.dart';

class ResendText extends StatelessWidget {
  const ResendText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: Insets.appConstantMedium,
        bottom: Insets.appConstantMedium,
        left: Insets.appConstantExtraLarge,
        right: Insets.appConstantMedium,
      ),
      child: Text(
        Strings.resendMessage,
        style: TextStyle(
          fontSize: FontsSize.large,
        ),
      ),
    );
  }
}
