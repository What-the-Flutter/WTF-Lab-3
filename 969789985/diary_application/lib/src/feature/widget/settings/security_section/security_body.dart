import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repository/security/security_repository.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/typedefs.dart';
import '../../../cubit/settings/security_cubit.dart';
import '../../../page/settings/security/passcode_warning_page.dart';
import '../general/settings_divider.dart';
import 'security_face_id_button.dart';
import 'security_fingerprint_button.dart';
import 'security_passcode_button.dart';

class SecurityBody extends StatelessWidget {
  const SecurityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _SecurityRow(
            secButton: const SecurityPasscodeButton(),
            secSwitch: BlocBuilder<SecurityCubit, SecurityState>(
              builder: (context, state) {
                return _SecuritySwitch(
                  positiveAction: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasscodeWarningPage(),
                    ),
                  ),
                  negativeAction: () =>
                      context.read<SecurityCubit>().disableSecurityMode(),
                  value: state.securityMode ==
                          SecurityMode.withPasscode.securityMode ||
                      state.securityMode ==
                          SecurityMode.withPasscodeAndBiometric.securityMode,
                );
              },
            ),
          ),
          const SettingsDivider(),
          _SecurityRow(
            secButton: const SecurityFingerprintButton(),
            secSwitch: BlocBuilder<SecurityCubit, SecurityState>(
              builder: (context, state) {
                return _SecuritySwitch(
                  positiveAction: () {
                    context.read<SecurityCubit>().securityMode =
                        SecurityMode.withFingerprint.securityMode;
                  },
                  negativeAction: () =>
                      context.read<SecurityCubit>().disableSecurityMode(),
                  value: state.securityMode ==
                          SecurityMode.withFingerprint.securityMode ||
                      state.securityMode ==
                          SecurityMode.withPasscodeAndBiometric.securityMode,
                );
              },
            ),
          ),
          const SettingsDivider(),
          _SecurityRow(
            secButton: const SecurityFaceIdButton(),
            secSwitch: BlocBuilder<SecurityCubit, SecurityState>(
              builder: (context, state) {
                return _SecuritySwitch(
                  positiveAction: () => context
                      .read<SecurityCubit>()
                      .securityMode = SecurityMode.withFaceId.securityMode,
                  negativeAction: () =>
                      context.read<SecurityCubit>().disableSecurityMode(),
                  value: state.securityMode ==
                          SecurityMode.withFaceId.securityMode ||
                      state.securityMode ==
                          SecurityMode.withPasscodeAndBiometric.securityMode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SecuritySwitch extends StatelessWidget {
  final Callback positiveAction;
  final Callback negativeAction;
  final bool value;

  const _SecuritySwitch({
    Key? key,
    required this.positiveAction,
    required this.negativeAction,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      onChanged: context.watch<SecurityCubit>().state.isDeviceSupportedBiometric
          ? (value) {
              if (value) {
                positiveAction.call();
              } else {
                negativeAction.call();
              }
            }
          : null,
      value: value,
      activeColor: Colors.green,
    );
  }
}

class _SecurityRow extends StatelessWidget {
  final Widget secButton;
  final Widget secSwitch;

  const _SecurityRow({
    super.key,
    required this.secButton,
    required this.secSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: secButton,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
          ),
          child: BlocBuilder<SecurityCubit, SecurityState>(
            builder: (context, state) {
              return secSwitch;
            },
          ),
        ),
        const SizedBox(width: Insets.large),
      ],
    );
  }
}
