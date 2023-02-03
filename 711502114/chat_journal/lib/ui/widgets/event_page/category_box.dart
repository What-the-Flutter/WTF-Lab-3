import 'package:flutter/material.dart';

import '../../../data/source.dart';
import '../../../models/category.dart';
import '../../../theme/colors.dart';

class CategoryBox extends StatelessWidget {
  final Function(Category? category) setCategory;

  const CategoryBox({Key? key, required this.setCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddings = const EdgeInsets.symmetric(horizontal: 15, vertical: 10);
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setCategory(index != 0 ? categories[index] : null);
            },
            child: Padding(
              padding: paddings,
              child: Column(
                children: [
                  _buildCircleAvatar(index),
                  Text(categories[index].title)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircleAvatar(int index) {
    return CircleAvatar(
      backgroundColor: index == 0 ? Colors.transparent : circleMessageColor,
      foregroundColor: index == 0 ? Colors.red : Colors.white,
      radius: 25,
      child: Icon(categories[index].icon),
    );
  }
}
