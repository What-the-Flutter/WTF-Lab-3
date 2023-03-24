import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';

class ChatIcon extends StatelessWidget {
  const ChatIcon({
    Key? key,
    required this.child,
    required this.index,
    required this.pageIndex,
  }) : super(key: key);

  final Widget child;
  final int index, pageIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(
            minHeight: 65,
            minWidth: 65,
          ),
          decoration: BoxDecoration(
            color: addChatColor,
            shape: BoxShape.circle,
          ),
          child: child,
        ),
        if (pageIndex == index)
          Positioned(
            right: 5,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: const Icon(
                Icons.check,
                size: 13,
              ),
            ),
          )
      ],
    );
  }
}
