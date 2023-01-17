import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/locale_cubit.dart';
import '../data/locale_repository.dart';

class LocaleScope extends StatelessWidget {
  const LocaleScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit(
        localeRepository: LocaleRepository(),
      ),
      child: child,
    );
  }
}
