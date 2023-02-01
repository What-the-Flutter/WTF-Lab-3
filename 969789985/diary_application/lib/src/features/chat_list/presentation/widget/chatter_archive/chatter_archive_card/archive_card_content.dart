import 'package:flutter/material.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/values/icons.dart';

class ArchiveCardContent extends StatelessWidget {
  const ArchiveCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.archive,
              size: IconsSize.extraLarge,
            ),
            const SizedBox(width: Insets.appConstantMedium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Archive'),
                /*Text(
                    archiveList.isNotEmpty
                        ? archiveList.length == 1
                            ? archiveList.first.chatTitle
                            : '${archiveList.first.chatTitle}...'
                        : 'Archive is empty',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),*/
              ],
            ),
          ],
        ),
      ],
    );
  }
}