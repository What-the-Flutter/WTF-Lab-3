import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../cubit/settings/appearance_cubit.dart';

class TagExample extends StatelessWidget {
  final AppearanceState state;

  const TagExample({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.circle),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: Insets.medium,
          right: Insets.medium,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: Insets.small,
            bottom: Insets.small,
            left: Insets.small,
            right: Insets.medium,
          ),
          child: Row(
            children: [
              const SizedBox(width: Insets.small),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Icon(
                  key: ValueKey<String>(state.selectedIcon.toString()),
                  IconData(
                    state.selectedIcon,
                    fontFamily: AppIcons.material,
                  ),
                ),
              ),
              const SizedBox(width: Insets.small),
              Text(state.tagText),
            ],
          ),
        ),
      ),
    );
  }
}
