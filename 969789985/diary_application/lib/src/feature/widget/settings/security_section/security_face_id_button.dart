import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repository/security/security_repository.dart';
import '../../../cubit/settings/security_cubit.dart';
import '../../../page/settings/security/security_passcode_page.dart';
import '../general/settings_button_foundation.dart';

class SecurityFaceIdButton extends StatelessWidget {
  const SecurityFaceIdButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButtonFoundation(
      action: () =>
          context.read<SecurityCubit>().state.isDeviceSupportedBiometric
              ? context.read<SecurityCubit>().securityMode =
                  SecurityMode.withFaceId.securityMode
              : null,
      buttonTitle: 'Face ID',
      buttonDescription: 'Use your device\'s Face ID',
      iconCodePoint: Icons.face.codePoint,
      isRemovable: false,
    );
  }
}
