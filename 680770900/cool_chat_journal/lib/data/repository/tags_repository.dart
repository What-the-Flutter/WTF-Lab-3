import '../models/tag.dart';
import '../provider/database_provider.dart';

class TagsRepository {
  final DatabaseProvider databaseProvider;

  const TagsRepository({
    required this.databaseProvider,
  });

  Future<void> addTag(String rawValue) async {
    final String value;
    if (rawValue.startsWith('#')) {
      value = rawValue.substring(1);
    } else {
      value = rawValue;
    }

    final json = await databaseProvider.read<Tag>(
      tableName: '${DatabaseProvider.tagsRoot}',
    );

    final tags = json.map(Tag.fromJson).where((t) => t.id == value).toList();

    if (tags.isEmpty) {
      await databaseProvider.add(
        json: Tag(
          id: value,
          count: 1,
        ).toJson(),
        tableName: DatabaseProvider.tagsRoot,
      );
    } else {
      await databaseProvider.delete(
        id: value,
        tableName: DatabaseProvider.tagsRoot,
      );

      final newTag = tags.first.copyWith(count: tags.first.count + 1);

      await databaseProvider.add(
        json: newTag.toJson(),
        tableName: DatabaseProvider.tagsRoot,
      );
    }
  }

  Future<void> deleteLink(String tagId) async {
    final json = await databaseProvider.read<Tag>(
      tableName: DatabaseProvider.tagsRoot,
    );

    await databaseProvider.delete(
      id: tagId,
      tableName: DatabaseProvider.tagsRoot,
    );

    final tag = Tag.fromJson(json.first);
    final newTag = tag.copyWith(count: tag.count - 1);

    if (newTag.count > 0) {
      await addTag(newTag.id);
    }
  }

  Stream<List<Tag>> get tagsStream => databaseProvider.tagsStream;
}
