import 'package:flutter/material.dart';

class IconView extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? size;

  const IconView({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: size,
            height: size,
            margin: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: Icon(
              icon,
              color: colorScheme.onBackground,
              size: 45.0,
            ),
          ),

          if (isSelected)
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: colorScheme.background,
                ),
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Icon(
                Icons.done,
                color: Theme.of(context).colorScheme.onBackground,
                size: 25.0,
              ),
            ),
        ]
      ),
    );
  }

}