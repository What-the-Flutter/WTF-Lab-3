import 'package:flutter/material.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../general/passcode/passcode_numbers.dart';
import '../../general/passcode/passcode_points.dart';

class SafetyPasscodeBody extends StatelessWidget {
  const SafetyPasscodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: Insets.superMegaExtraLarge),
        const Text(
          'ENTER PASSCODE',
          style: TextStyle(
            fontSize: FontsSize.large,
          ),
        ),
        const Text(
          'Please enter your passcode',
          style: TextStyle(fontSize: FontsSize.middle),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Insets.superMegaLarge),
        const PasscodePoints(),
        const SizedBox(height: Insets.superMegaLarge),
        const PasscodeNumbers(isAuth: true),
        const SizedBox(height: Insets.large),
      ],
    );
  }
}
