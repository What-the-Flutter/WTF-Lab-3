import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../../core/util/resources/strings.dart';
import 'security_set_passcode_button.dart';

class SecurityPasscodeWarningBody extends StatelessWidget {
  const SecurityPasscodeWarningBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.large),
      child: Column(
        children: [
          const SizedBox(height: Insets.superDuperUltraMegaExtraLarge * 1.3),
          const Icon(
            Icons.key,
            size: IconsSize.superExtraLarge * 2,
          ),
          const Text(
            'SET PASSCODE',
            style: TextStyle(
              fontSize: FontsSize.extraLarge,
            ),
          ),
          const SizedBox(height: Insets.medium),
          const Text(
            Strings.passcodeWarning,
            style: TextStyle(
              fontSize: FontsSize.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            children: [
              const Expanded(
                child: SecuritySetPasscodeButton(),
              ),
            ],
          ),
          const SizedBox(height: Insets.extraLarge),
        ],
      ),
    );
  }
}
