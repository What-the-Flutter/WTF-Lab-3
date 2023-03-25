import 'package:firebase_auth/firebase_auth.dart';

import '../models/tag.dart';
import '../provider/database_provider.dart';

class TagsRepository {
  final DatabaseProvider _databaseProvider;

  TagsRepository({required User? user})
      : _databaseProvider = DatabaseProvider(user: user);

  Future<List<Tag>> readTags() async {
    final jsonTags = await _databaseProvider.read<Tag>(
      tableName: DatabaseProvider.tagsRoot,
    );

    return jsonTags.map(Tag.fromJson).toList();
  }

  Future<void> addTag(Tag tag) async =>
      await _databaseProvider.add(
        json: tag.toJson(),
        tableName: DatabaseProvider.tagsRoot,
      );

  Future<void> deleteLink(String tagId) async {
    final json = await _databaseProvider.read<Tag>(
      tableName: '${DatabaseProvider.tagsRoot}/$tagId',
    );

    await _databaseProvider.delete(
      id: tagId,
      tableName: DatabaseProvider.tagsRoot,
    );

    final tag = Tag.fromJson(json.first);
    final newTag = tag.copyWith(count: tag.count - 1);
    
    if (newTag.count > 0) {
      await addTag(newTag);
    }
  } 
}
