import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/appearance_cubit.dart';
import '../widget/appearance_section/appearance_body.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        centerTitle: false,
      ),
      body: const AppearanceBody(),
    );
  }
}
