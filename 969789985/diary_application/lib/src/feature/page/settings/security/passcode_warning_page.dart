import 'package:flutter/material.dart';

import '../../../widget/settings/security_section/passcode/security_passcode_warning_body.dart';

class PasscodeWarningPage extends StatelessWidget {
  const PasscodeWarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SecurityPasscodeWarningBody(),
    );
  }
}