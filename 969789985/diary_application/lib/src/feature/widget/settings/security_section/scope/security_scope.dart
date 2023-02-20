import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/repository/security/security_repository.dart';
import '../../../../cubit/settings/security_cubit.dart';

class SecurityScope extends StatelessWidget {
  final Widget child;

  const SecurityScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecurityCubit(
        repository: SecurityRepository(),
      ),
      child: child,
    );
  }

  static SecurityCubit of(BuildContext context) =>
      context.read<SecurityCubit>();
}
