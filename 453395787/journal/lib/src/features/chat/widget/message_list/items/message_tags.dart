import 'package:flutter/material.dart';

import '../../../../../common/models/ui/tag.dart';
import '../../../../../common/utils/insets.dart';
import '../../../../../common/utils/typedefs.dart';
import '../../tag_selector/tag_item.dart';

class MessageTags extends StatelessWidget {
  const MessageTags({
    super.key,
    required this.tags,
    this.selectedId,
    this.spacing = Insets.small,
    this.alignment = WrapAlignment.end,
    this.onPressed,
  });

  final TagList tags;
  final String? selectedId;
  final double spacing;
  final WrapAlignment alignment;
  final void Function(Tag tag)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: alignment,
      children: tags.map(
        (tag) {
          return TagItem(
            color: tag.color,
            text: tag.text,
            isSelected: selectedId == tag.id,
            onPressed: onPressed == null ? null : (_) => onPressed!(tag),
          );
        },
      ).toList(),
    );
  }
}
