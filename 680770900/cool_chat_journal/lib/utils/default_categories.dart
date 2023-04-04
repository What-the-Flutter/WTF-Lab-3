import 'package:flutter/material.dart';

import '../data/json_kit.dart';
import '../data/models/category.dart';

abstract class DefaultCategories {
  static List<JsonMap> get jsonList => list.map((e) => e.toJson()).toList();

  static List<Category> get list => [
        Category(
          title: 'test',
          icon: Icons.fitness_center.codePoint,
          isCustom: false,
        ),
      ];
}
