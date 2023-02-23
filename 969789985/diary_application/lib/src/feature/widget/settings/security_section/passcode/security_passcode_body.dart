import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/strings.dart';
import '../../../general/passcode/passcode_numbers.dart';
import '../../../general/passcode/passcode_points.dart';

class SecurityPasscodeBody extends StatelessWidget {
  const SecurityPasscodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Insets.superMegaLarge),
        const Text(
          'ENTER PASSCODE',
          style: TextStyle(
            fontSize: FontsSize.large,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          Strings.passcodeInf,
          style: TextStyle(
            fontSize: FontsSize.middle,
          ),
        ),
        const SizedBox(height: Insets.superMegaLarge),
        const PasscodePoints(),
        const SizedBox(height: Insets.superMegaLarge),
        const PasscodeNumbers(isAuth: false),
        const SizedBox(height: Insets.large),
      ],
    );
  }
}
