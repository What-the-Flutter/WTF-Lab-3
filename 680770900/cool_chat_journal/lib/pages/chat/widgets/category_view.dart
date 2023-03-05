import 'package:flutter/material.dart';

import '../../../model/category.dart';

class CategoryView extends StatelessWidget {
  final Category category;

  const CategoryView({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(category.icon),
        Text(category.name),
      ],
    );
  }
}
