import '../models/category.dart';
import '../provider/database_provider.dart';

class CategoriesRepository {
  final DatabaseProvider databaseProvider;

  const CategoriesRepository({
    required this.databaseProvider,
  });

  Future<void> addCategory(Category category) async =>
      await databaseProvider.add(
        json: category.toJson(),
        tableName: DatabaseProvider.categoriesRoot,
      );

  Future<void> deleteCategory(String categoryId) async =>
      await databaseProvider.delete(
        id: categoryId,
        tableName: DatabaseProvider.categoriesRoot,
      );

  Stream<List<Category>> get categoriesStream =>
      databaseProvider.categoriesStream;
}
