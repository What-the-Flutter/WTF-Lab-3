import 'package:flutter/material.dart';

class ChatItemSmall extends StatelessWidget {
  const ChatItemSmall({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: FilterChip(
        showCheckmark: false,
        onSelected: (_) => onTap(),
        selected: isSelected,
        label: Column(
          children: [
            Icon(icon),
            Text(text),
          ],
        ),
      ),
    );
  }
}
