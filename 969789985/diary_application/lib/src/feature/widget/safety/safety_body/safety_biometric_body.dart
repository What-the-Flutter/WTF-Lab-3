import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repository/security/security_repository.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/icons.dart';
import '../../../cubit/settings/security_cubit.dart';
import '../../../page/safety/safety_passcode_page.dart';
import '../../../start_screen.dart';

class SafetyBiometricBody extends StatefulWidget {
  const SafetyBiometricBody({super.key});

  @override
  State<SafetyBiometricBody> createState() => _SafetyBiometricBodyState();
}

class _SafetyBiometricBodyState extends State<SafetyBiometricBody> {
  late bool _isAuth;

  @override
  void initState() {
    _isAuth = context.read<SecurityCubit>().state.securityMode !=
        SecurityMode.noneSecurity;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: Insets.superDuperUltraMegaExtraLarge * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _auth();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.amber.shade50,
                    radius: IconsSize.superExtraLarge * 1.6,
                    child: Container(
                      width: Insets.superMegaExtraLarge * 2.5,
                      height: Insets.superMegaExtraLarge * 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Radii.circle),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.red.shade300,
                            Colors.orange,
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.fingerprint,
                        size: IconsSize.superExtraLarge * 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: Insets.superDuperUltraMegaExtraLarge * 2),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.circle),
              ),
              onPressed: () async => await _auth(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: Insets.large),
                child: Text(
                  'TRY AGAIN',
                  style: TextStyle(fontSize: FontsSize.large),
                ),
              ),
            ),
            const Spacer(),
            Visibility(
              visible: state.securityMode ==
                  SecurityMode.withPasscodeAndBiometric.securityMode,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.circle),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SafetyPasscodePage(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: Insets.large),
                  child: Text(
                    'Enter your passcode',
                    style: TextStyle(
                      fontSize: FontsSize.normal,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Insets.superDuperUltraMegaExtraLarge),
          ],
        );
      },
    );
  }

  Future<void> _auth() async {
    final isAuth = await context.read<SecurityCubit>().authenticate();
    setState(() {
      _isAuth = isAuth;
    });

    if (_isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StartScreen(),
        ),
      );
    }
  }
}
