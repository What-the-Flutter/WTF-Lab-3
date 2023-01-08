import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../../../common/data/models/tag.dart';
import '../../../../../common/utils/insets.dart';
import '../../../../message_input/view/chat_input.dart';

class ItemTags extends StatelessWidget {
  const ItemTags({super.key, required this.tags});

  final IList<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Insets.small,
      runSpacing: Insets.small,
      alignment: WrapAlignment.end,
      children: tags.map(
        (e) {
          return TagItem(
            color: e.color,
            text: e.text,
          );
        },
      ).toList(),
    );
  }
}
