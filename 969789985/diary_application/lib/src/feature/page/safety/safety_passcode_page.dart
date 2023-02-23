import 'package:flutter/material.dart';

import '../../widget/safety/safety_body/safety_passcode_body.dart';

class SafetyPasscodePage extends StatelessWidget {
  const SafetyPasscodePage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: SafetyPasscodeBody(),
  );
}
