import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/repository/theme/theme_repository.dart';
import '../../cubit/theme/theme_cubit.dart';

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

  static ThemeCubit of(BuildContext context) => context.read<ThemeCubit>();
}
