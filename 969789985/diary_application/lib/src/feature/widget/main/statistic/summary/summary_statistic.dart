import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../timeline/scope/timeline_scope.dart';

class SummaryStatistic extends StatelessWidget {
  const SummaryStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.appConstant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.medium,
          horizontal: Insets.medium,
        ),
        child: Column(
          children: [
            const Text(
              'In total',
              style: TextStyle(
                fontSize: FontsSize.extraLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You have left',
                  style: TextStyle(
                    fontSize: FontsSize.large,
                  ),
                ),
                Text(
                  ' ${TimelineScope.of(context).state.defaultMessages.length} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontsSize.large,
                  ),
                ),
                const Text(
                  'messages',
                  style: TextStyle(
                    fontSize: FontsSize.large,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'in',
                  style: TextStyle(
                    fontSize: FontsSize.large,
                  ),
                ),
                Text(
                  ' ${TimelineScope.of(context).state.chats.length} ',
                  style: const TextStyle(
                    fontSize: FontsSize.large,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  style: TextStyle(
                    fontSize: FontsSize.large,
                  ),
                  'chats',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Attached',
                  style: TextStyle(
                    fontSize: FontsSize.large,
                  ),
                ),
                Text(
                  ' ${TimelineScope.of(context).countFiles()} ',
                  style: const TextStyle(
                    fontSize: FontsSize.large,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  TimelineScope.of(context).countFiles() == 1
                      ? 'file'
                      : 'files',
                  style: const TextStyle(
                    fontSize: FontsSize.large,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Created',
                  style: TextStyle(
                    fontSize: FontsSize.large,
                  ),
                ),
                Text(
                  ' ${TimelineScope.of(context).state.tags.length} ',
                  style: const TextStyle(
                    fontSize: FontsSize.large,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  TimelineScope.of(context).state.tags == 1 ? 'tag' : 'tags',
                  style: const TextStyle(
                    fontSize: FontsSize.large,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
