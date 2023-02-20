import 'package:flutter/material.dart';

import '../../../widget/settings/security_section/security_body.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
        centerTitle: false,
      ),
      body: const SecurityBody(),
    );
  }
}