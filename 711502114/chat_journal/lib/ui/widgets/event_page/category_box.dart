import 'package:flutter/material.dart';

import '../../../data/category_store.dart';
import '../../../models/category.dart';
import '../../../theme/colors.dart';

class CategoryBox extends StatelessWidget {
  final Function(Category? category) setCategory;

  const CategoryBox({Key? key, required this.setCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddings = const EdgeInsets.symmetric(horizontal: 15, vertical: 10);
    final store = CategoryStore(context: context);
    return Container(
      height: 90,
      color: messageBlocColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: store.categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setCategory(index != 0 ? store.categories[index] : null);
            },
            child: Padding(
              padding: paddings,
              child: Column(
                children: [
                  _buildCircleAvatar(store.categories[index].icon, index),
                  Text(store.categories[index].title)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircleAvatar(IconData icon, int index) {
    return CircleAvatar(
      backgroundColor: index == 0 ? Colors.transparent : circleMessageColor,
      foregroundColor: index == 0 ? Colors.red : Colors.white,
      radius: 25,
      child: Icon(icon),
    );
  }
}
