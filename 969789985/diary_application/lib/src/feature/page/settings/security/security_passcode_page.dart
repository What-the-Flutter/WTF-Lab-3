import 'package:flutter/material.dart';

import '../../../widget/settings/security_section/passcode/security_passcode_body.dart';
import '../../../widget/settings/security_section/passcode/security_passcode_action.dart';

class SecurityPasscodePage extends StatelessWidget {
  const SecurityPasscodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passcode'),
        centerTitle: false,
        actions: [
          const SecurityPasscodeAction(),
        ],
      ),
      body: const SecurityPasscodeBody(),
    );
  }
}
