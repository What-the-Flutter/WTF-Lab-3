import 'package:flutter/material.dart';

import '../../widget/safety/safety_body/safety_biometric_body.dart';

class SafetyBiometricPage extends StatelessWidget {
  const SafetyBiometricPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SafetyBiometricBody(),
      );
}
