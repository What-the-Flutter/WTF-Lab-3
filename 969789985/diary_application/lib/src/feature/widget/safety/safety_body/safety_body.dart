import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/strings.dart';
import '../../../cubit/settings/security_cubit.dart';
import '../../../start_screen.dart';
import 'safety_biometric_body.dart';
import 'safety_passcode_body.dart';

class SafetyBody extends StatelessWidget {
  const SafetyBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, state) {
        return _SafetySelection(state: state);
      },
    );
  }
}

class _SafetySelection extends StatelessWidget {
  final SecurityState state;

  const _SafetySelection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.securityMode) {
      case AuthSelections.noneSecurity:
        return const StartScreen();
      case AuthSelections.withPasscode:
        return const SafetyPasscodeBody();
      case AuthSelections.withFingerprint:
        return const SafetyBiometricBody();
      case AuthSelections.withFaceId:
        return const SafetyBiometricBody();
      case AuthSelections.withPasscodeAndBiometric:
        return const SafetyPasscodeBody();
      default:
        return const Center(
          child: Text('What have you done mister?'),
        );
    }
  }
}
