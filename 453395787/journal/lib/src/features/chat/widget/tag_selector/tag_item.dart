import 'package:flutter/material.dart';

import '../../../../common/extensions/color_extensions.dart';
import '../../../../common/utils/insets.dart';

class TagItem extends StatelessWidget {
  const TagItem({
    super.key,
    required this.color,
    required this.text,
    this.onPressed,
    this.isSelected = false,
    this.isEnabled = false,
  });

  final Color color;
  final String text;
  final bool isSelected;
  final bool isEnabled;
  final void Function(bool)? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(text),
      labelStyle: TextStyle(
        color: color.withBrightness(1.5),
        fontWeight: FontWeight.w400,
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: Insets.extraSmall,
      ),
      backgroundColor: color.withBrightness(0.3),
      selectedColor: Colors.black12,
      side: BorderSide(
        color: color,
        width: 2,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          width: 1,
          color: color.withBrightness(1.5),
        ),
      ),
      onSelected: onPressed ?? (_) {},
      selected: isSelected,
    );
  }
}
