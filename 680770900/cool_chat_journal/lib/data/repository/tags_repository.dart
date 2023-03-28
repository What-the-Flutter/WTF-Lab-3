import 'package:get_it/get_it.dart';

import '../models/tag.dart';
import '../provider/database_provider.dart';

class TagsRepository {
  const TagsRepository();

  Future<void> addTag(String rawValue) async {
    final String value;
    if (rawValue.startsWith('#')) {
      value = rawValue.substring(1);
    } else {
      value = rawValue;
    }

    final json = await GetIt.I<DatabaseProvider>().read<Tag>(
      tableName: '${DatabaseProvider.tagsRoot}',
    );

    final tags = json.map(Tag.fromJson).where((t) => t.id == value).toList();

    if (tags.isEmpty) {
      await GetIt.I<DatabaseProvider>().add(
        json: Tag(
          id: value,
          count: 1,
        ).toJson(),
        tableName: DatabaseProvider.tagsRoot,
      );
    } else {
      await GetIt.I<DatabaseProvider>().delete(
        id: value,
        tableName: DatabaseProvider.tagsRoot,
      );

      final newTag = tags.first.copyWith(count: tags.first.count + 1);

      await GetIt.I<DatabaseProvider>().add(
        json: newTag.toJson(),
        tableName: DatabaseProvider.tagsRoot,
      );
    }
  }

  Future<void> deleteLink(String tagId) async {
    final json = await GetIt.I<DatabaseProvider>().read<Tag>(
      tableName: DatabaseProvider.tagsRoot,
    );

    await GetIt.I<DatabaseProvider>().delete(
      id: tagId,
      tableName: DatabaseProvider.tagsRoot,
    );

    final tag = Tag.fromJson(json.first);
    final newTag = tag.copyWith(count: tag.count - 1);

    if (newTag.count > 0) {
      await addTag(newTag.id);
    }
  }

  Stream<List<Tag>> get tagsStream => GetIt.I<DatabaseProvider>().tagsStream;
}
