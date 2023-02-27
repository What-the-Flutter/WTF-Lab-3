import 'package:flutter/material.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/icons.dart';

class BaseTagsBox extends StatelessWidget {
  final MessageModel message;

  const BaseTagsBox({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: message.tags
          .map(
            (tag) => Padding(
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
          )
          .toList(),
    );
  }
}
