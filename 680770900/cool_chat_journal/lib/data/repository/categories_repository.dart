import 'package:get_it/get_it.dart';

import '../models/category.dart';
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
