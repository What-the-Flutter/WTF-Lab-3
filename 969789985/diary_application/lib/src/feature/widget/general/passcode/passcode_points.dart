import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/settings/security_cubit.dart';
import '../../theme/theme_scope.dart';

class PasscodePoints extends StatelessWidget {
  const PasscodePoints({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimatedPoint(state: state, index: 0),
            const SizedBox(width: Insets.large * 1.5),
            _AnimatedPoint(state: state, index: 1),
            const SizedBox(width: Insets.large * 1.5),
            _AnimatedPoint(state: state, index: 2),
            const SizedBox(width: Insets.large * 1.5),
            _AnimatedPoint(state: state, index: 3),
          ],
        );
      },
    );
  }
}

class _AnimatedPoint extends StatelessWidget {
  final SecurityState state;
  final int index;

  const _AnimatedPoint({
    super.key,
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.circle),
        color: state.passcodeSequence.getOrNull(index) == null
            ? Color(ThemeScope.of(context).state.primaryItemColor)
            : Color(ThemeScope.of(context).state.primaryColor),
      ),
      width: state.passcodeSequence.getOrNull(index) == null ? 12.0 : 18.0,
      height: state.passcodeSequence.getOrNull(index) == null ? 12.0 : 18.0,
    );
  }
}
