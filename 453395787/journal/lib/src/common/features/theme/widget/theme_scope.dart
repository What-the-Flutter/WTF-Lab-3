import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';
import '../data/theme_repository.dart';

class ThemeScope extends StatelessWidget {
  const ThemeScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(
        repository: ThemeRepository(),
      ),
      child: child,
    );
  }

  static ThemeCubit of(BuildContext context) {
    return context.read<ThemeCubit>();
  }
}
