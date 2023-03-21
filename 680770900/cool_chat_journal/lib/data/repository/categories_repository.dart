import 'package:firebase_auth/firebase_auth.dart';

import '../models/category.dart';
import '../provider/database_provider.dart';

class CategoriesRepository {
  final DatabaseProvider _databaseProvider;

  CategoriesRepository({required User? user}) 
    : _databaseProvider = DatabaseProvider(user: user);


  Future<List<Category>> readCategories() async {
    final jsonCategories = await _databaseProvider.read<Category>(
      tableName: DatabaseProvider.categoriesRoot,
    );

    return jsonCategories.map(Category.fromJson).toList();
  }

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
}
