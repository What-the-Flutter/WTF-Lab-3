import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/main/start_screen_cubit.dart';

class StartScreenScope extends StatelessWidget {
  final Widget child;

  const StartScreenScope({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartScreenCubit(),
      child: child,
    );
  }

  static StartScreenCubit of(BuildContext context) =>
      context.read<StartScreenCubit>();
}
