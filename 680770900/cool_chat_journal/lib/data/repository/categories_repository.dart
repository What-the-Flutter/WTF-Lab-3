import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/json_kit.dart';
import '../provider/database_provider.dart';

class CategoriesRepository {
  final DatabaseProvider _databaseProvider;

  CategoriesRepository({required User? user})
      : _databaseProvider = DatabaseProvider(
          user: user,
          defaultJsonCategories: _BaseCategories.jsonList,
        );

  Future<void> addCategory(Category category) async =>
      await _databaseProvider.add(
        json: category.toJson(),
        tableName: DatabaseProvider.categoriesRoot,
      );

  Future<void> deleteCategory(String categoryId) async =>
      await _databaseProvider.delete(
        id: categoryId,
        tableName: DatabaseProvider.categoriesRoot,
      );

  Stream<List<Category>> get categoriesStream => 
      _databaseProvider.categoriesStream;
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
