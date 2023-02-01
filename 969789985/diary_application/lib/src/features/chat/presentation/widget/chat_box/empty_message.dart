import 'package:flutter/material.dart';

import '../../../../../common/values/icons.dart';

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: IconsSize.standard,
            color: Theme.of(context).hintColor,
          ),
          const Text(
            'Chat is empty',
          ),
        ],
      ),
    );
  }
}
