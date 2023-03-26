import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/category.dart';
import '../models/json_kit.dart';
import '../provider/database_provider.dart';

class CategoriesRepository {
  const CategoriesRepository();

  Future<void> addCategory(Category category) async =>
      await GetIt.I<DatabaseProvider>().add(
        json: category.toJson(),
        tableName: DatabaseProvider.categoriesRoot,
      );

  Future<void> deleteCategory(String categoryId) async =>
      await GetIt.I<DatabaseProvider>().delete(
        id: categoryId,
        tableName: DatabaseProvider.categoriesRoot,
      );

  Stream<List<Category>> get categoriesStream => 
      GetIt.I<DatabaseProvider>().categoriesStream;
}

class _BaseCategories {
  static List<JsonMap> get jsonList => list.map((e) => e.toJson()).toList();

  static List<Category> get list => [
    Category(
      title: 'test',
      icon: Icons.fitness_center.codePoint,
      isCustom: false,
    ),
  ];
}
