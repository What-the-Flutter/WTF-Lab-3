import 'package:flutter/material.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/utils/strings.dart';

class BottomSheetInformation extends StatelessWidget {
  const BottomSheetInformation({super.key});

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
