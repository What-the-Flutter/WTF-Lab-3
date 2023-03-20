import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/data/repository/security/security_repository.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/icons.dart';
import '../../../cubit/settings/security_cubit.dart';
import '../../../page/safety/safety_biometric_page.dart';
import '../../../start_screen.dart';
import '../../theme/theme_scope.dart';

class PasscodeNumbers extends StatelessWidget {
  final bool isAuth;

  const PasscodeNumbers({
    super.key,
    required this.isAuth,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Insets.appConstantSmall),
          child: Column(
            children: [
              _CodeRow(
                range: [1, 3],
                isAuth: isAuth,
              ),
              _CodeRow(
                range: [4, 6],
                isAuth: isAuth,
              ),
              _CodeRow(
                range: [7, 9],
                isAuth: isAuth,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isAuth &&
                          state.securityMode ==
                              SecurityMode.withPasscodeAndBiometric.securityMode
                      ? _CodeButton(
                          content: const Icon(Icons.fingerprint),
                          action: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SafetyBiometricPage(),
                            ),
                          ),
                        )
                      : _CodeButton(
                          content: const Text(
                            'Cancel',
                          ),
                          action: () =>
                              context.read<SecurityCubit>().removePasscode(),
                        ),
                  _CodeButton(
                    content: const Text(
                      '0',
                      style: TextStyle(fontSize: FontsSize.extraLarge),
                    ),
                    action: () {
                      context.read<SecurityCubit>().onPasscodeChanged(
                            passcode: 0,
                            action: () => () => _changedAction(context, state),
                            authValue: isAuth,
                          );
                    },
                  ),
                  _CodeButton(
                    content: const Icon(
                      Icons.close,
                      size: IconsSize.small * 1.5,
                    ),
                    action: () =>
                        context.read<SecurityCubit>().removeOnePasscodeNumber(),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _changedAction(BuildContext context, SecurityState state) {
    if (state.isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StartScreen(),
        ),
      );
    } else {
      Navigator.pop(context);

      Fluttertoast.showToast(
        msg: 'Passcode has been set successfully',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}

class _CodeRow extends StatelessWidget {
  final List<int> range;
  final bool isAuth;

  const _CodeRow({
    super.key,
    required this.range,
    required this.isAuth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = range[0]; i <= range[1]; i++)
          _CodeButton(
            content: Text(
              '$i',
              style: const TextStyle(
                fontSize: FontsSize.extraLarge,
              ),
            ),
            action: () {
              context.read<SecurityCubit>().onPasscodeChanged(
                    passcode: i,
                    action: () => _changedAction(
                      context,
                      context.read<SecurityCubit>().state,
                    ),
                    authValue: isAuth,
                  );
            },
          ),
      ],
    );
  }

  void _changedAction(BuildContext context, SecurityState state) {
    if (state.isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StartScreen(),
        ),
      );
    } else {
      Navigator.pop(context);

      Fluttertoast.showToast(
        msg: 'Passcode has been set successfully',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}

class _CodeButton extends StatelessWidget {
  final Widget content;
  final VoidCallback action;

  const _CodeButton({
    super.key,
    required this.content,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.appConstantSmall),
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(Radii.circle),
            splashColor: Color(ThemeScope.of(context).state.primaryColor),
            hoverColor: Color(ThemeScope.of(context).state.primaryColor),
            highlightColor: Color(ThemeScope.of(context).state.primaryColor),
            onTap: action.call,
            child: Center(
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
