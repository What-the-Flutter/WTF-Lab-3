import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';

class ArchiveCardContent extends StatelessWidget {
  const ArchiveCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.archive,
              size: IconsSize.superExtraLarge,
            ),
            SizedBox(width: Insets.appConstantSmall),
            Text(
              'Archive',
              style: TextStyle(fontSize: FontsSize.normal),
            ),
          ],
        ),
      ],
    );
  }
}
