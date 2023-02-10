import 'package:flutter/material.dart';

import '../../../../common/values/dimensions.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: Insets.dividerConstant,
        right: Insets.large,
      ),
      child: Divider(),
    );
  }
}