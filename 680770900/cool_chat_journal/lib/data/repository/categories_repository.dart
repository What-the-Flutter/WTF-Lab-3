import '../models/category.dart';
import '../provider/database_provider.dart';

class CategoriesRepository {
  final DatabaseProvider _databaseProvider;

  const CategoriesRepository(this._databaseProvider);

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
