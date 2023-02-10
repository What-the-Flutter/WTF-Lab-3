import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/setting_body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).setting_title,
          style: TextStyle(
            fontSize: context.watch<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
          ),
        ),
      ),
      body: const SettingBody(),
    );
  }
}
