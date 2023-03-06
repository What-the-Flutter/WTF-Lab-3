import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/repository/authenticate/authenticate_repository.dart';
import '../../cubit/f_authenticate/f_authenticate_cubit.dart';

class FAuthScope extends StatelessWidget {
  final Widget child;

  const FAuthScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FAuthenticateCubit(
        repository: const AuthenticateRepository(),
      ),
      child: child,
    );
  }

  static FAuthenticateCubit of(BuildContext context) =>
      context.read<FAuthenticateCubit>();
}
