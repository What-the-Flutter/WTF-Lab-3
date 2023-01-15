import 'package:flutter/material.dart';

import '../../../common/utils/insets.dart';
import '../../../common/utils/radius.dart';
import '../data/theme_repository.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
    required this.onTap,
    required this.selectedColor,
  });

  final void Function(Color color) onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        top: Insets.extraLarge,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 35,
        mainAxisSpacing: Insets.extraLarge,
        crossAxisSpacing: Insets.extraLarge,
      ),
      itemCount: ThemeRepository.colors.length,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(Radius.extraLarge),
          onTap: () => onTap(
            ThemeRepository.colors[index],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ThemeRepository.colors[index],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                Insets.extraSmall,
              ),
              child: selectedColor == ThemeRepository.colors[index]
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
