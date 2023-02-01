import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/settings_cubit.dart';
import '../data/settings_repository.dart';

class SettingsScope extends StatelessWidget {
  const SettingsScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        settingsRepository: SettingsRepository(),
      ),
      child: child,
    );
  }
}
