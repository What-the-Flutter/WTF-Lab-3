import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/resources/strings.dart';
import '../../cubit/main/start_screen_cubit.dart';

class AnimatedMainTitle extends StatelessWidget {
  const AnimatedMainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartScreenCubit, StartScreenState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              axis: Axis.horizontal,
              sizeFactor: animation,
              child: child,
            );
          },
          child: Text(
            MainTitles.mainTitles[state.pageIndex],
            key: ValueKey<int>(state.pageIndex),
          ),
        );
      },
    );
  }
}
