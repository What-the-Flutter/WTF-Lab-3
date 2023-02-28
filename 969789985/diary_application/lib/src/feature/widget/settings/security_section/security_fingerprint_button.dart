import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repository/security/security_repository.dart';
import '../../../cubit/settings/security_cubit.dart';
import '../general/settings_button_foundation.dart';

class SecurityFingerprintButton extends StatelessWidget {
  const SecurityFingerprintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () =>
          context.read<SecurityCubit>().state.isDeviceSupportedBiometric
              ? context.read<SecurityCubit>().securityMode =
                  SecurityMode.withFaceId.securityMode
              : null,
      buttonTitle: 'Fingerprint',
      buttonDescription: 'Use your device\'s fingerprint',
      iconCodePoint: Icons.fingerprint.codePoint,
      isRemovable: false,
    );
  }
}
