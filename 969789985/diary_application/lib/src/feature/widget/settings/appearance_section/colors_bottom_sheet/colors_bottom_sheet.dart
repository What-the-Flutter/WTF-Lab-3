import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import 'colors_selector.dart';

class ColorsBottomSheet extends StatelessWidget {
  const ColorsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.appConstantMedium),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radii.appConstant),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        constraints: const BoxConstraints(maxHeight: 300.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Insets.large),
            const Padding(
              padding: EdgeInsets.only(
                left: Insets.extraLarge,
              ),
              child: Text(
                'Choose a color palette',
                style: TextStyle(fontSize: FontsSize.normal),
              ),
            ),
            const Expanded(
              child: ColorsSelector(),
            ),
            const SizedBox(height: Insets.large),
          ],
        ),
      ),
    );
  }
}
