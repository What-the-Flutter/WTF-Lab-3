import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class PageIcon extends StatelessWidget {
  const PageIcon(
      {Key? key,
      required this.child,
      required this.index,
      required this.pageIndex})
      : super(key: key);

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
          decoration: const BoxDecoration(
            color: botBackgroundColor,
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
