import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/features/theme/theme.dart';
import '../../../common/utils/insets.dart';
import '../cubit/security_cubit.dart';
import '../data/security_repository.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecurityCubit(
        securityRepository: SecurityRepository(),
      ),
      child: BlocBuilder<SecurityCubit, SecurityState>(
        builder: (context, state) {
          context.read<SecurityCubit>().verify();
          return state.map(
            initial: (initial) {
              return _VerifyPageBody(
                tryAgainCallback: context.read<SecurityCubit>().verify,
              );
            },
            success: (success) => widget.child,
          );
        },
      ),
    );
  }
}

class _VerifyPageBody extends StatelessWidget {
  const _VerifyPageBody({
    super.key,
    required this.tryAgainCallback,
  });

  final VoidCallback tryAgainCallback;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: state.color,
            brightness: state.isDarkMode ? Brightness.dark : Brightness.light,
          ),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      Insets.extraLarge,
                    ),
                    child: IconButton(
                      onPressed: tryAgainCallback,
                      icon: Icon(
                        Icons.fingerprint_outlined,
                        size: 96,
                        color: state.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
