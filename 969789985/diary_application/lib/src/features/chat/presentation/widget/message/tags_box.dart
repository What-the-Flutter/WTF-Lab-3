import 'package:flutter/material.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../../../common/values/icons.dart';
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
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(Radii.circle),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Insets.small),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconData(tag.tagIcon, fontFamily: AppIcons.material),
                    ),
                    Text('${tag.tagTitle}  '),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
