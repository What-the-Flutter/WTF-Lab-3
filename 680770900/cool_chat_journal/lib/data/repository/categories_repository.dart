import '../models/models.dart';
import '../provider/database_provider.dart';

class CategoriesRepository {
  final DatabaseProvider _dbProvider = DatabaseProvider();

  Future<List<Category>> loadCategories() async => _dbProvider.loadCategories();

  Future<void> saveCategories(List<Category> categories) async =>
    _dbProvider.saveCategories(categories);

  Future<void> addCategory(Category category) async {
    final categories = await _dbProvider.loadCategories();
    categories.add(category);
    await _dbProvider.saveCategories(categories);
  }

  Future<void> deleteCategory(String categoryId) async {
    final categories = await _dbProvider.loadCategories();
    await _dbProvider.saveCategories(
      categories.where((category) => category.id != categoryId),
    );
  }
}
