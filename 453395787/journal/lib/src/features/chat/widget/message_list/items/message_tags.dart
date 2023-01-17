import 'package:flutter/material.dart';

import '../../../../../common/utils/insets.dart';
import '../../../../../common/utils/typedefs.dart';
import '../../tag_selector/tag_item.dart';

class MessageTags extends StatelessWidget {
  const MessageTags({
    super.key,
    required this.tags,
  });

  final TagList tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Insets.small,
      runSpacing: Insets.small,
      alignment: WrapAlignment.end,
      children: tags.map(
        (tag) {
          return TagItem(
            color: tag.color,
            text: tag.text,
          );
        },
      ).toList(),
    );
  }
}
