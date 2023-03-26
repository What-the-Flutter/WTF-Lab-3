import 'package:get_it/get_it.dart';

import '../models/tag.dart';
import '../provider/database_provider.dart';

class TagsRepository {
  const TagsRepository();

  Future<void> addTag(Tag tag) async =>
      await GetIt.I<DatabaseProvider>().add(
        json: tag.toJson(),
        tableName: DatabaseProvider.tagsRoot,
      );

  Future<void> deleteLink(String tagId) async {
    final json = await GetIt.I<DatabaseProvider>().read<Tag>(
      tableName: '${DatabaseProvider.tagsRoot}/$tagId',
    );

    await GetIt.I<DatabaseProvider>().delete(
      id: tagId,
      tableName: DatabaseProvider.tagsRoot,
    );

    final tag = Tag.fromJson(json.first);
    final newTag = tag.copyWith(count: tag.count - 1);
    
    if (newTag.count > 0) {
      await addTag(newTag);
    }
  } 

  Stream<List<Tag>> get tagsStream => GetIt.I<DatabaseProvider>().tagsStream;
}
