import 'package:flutter/material.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../domain/message_model.dart';

class TagsBox extends StatelessWidget {
  final MessageModel message;

  const TagsBox({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        for (final tag in message.tags)
          Padding(
            padding: const EdgeInsets.all(
              Insets.small,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radii.circle),
                border: Border.all(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Insets.medium),
                child: Text(tag),
              ),
            ),
          ),
      ],
    );
  }
}
