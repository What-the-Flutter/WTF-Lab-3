import 'dart:async';

import '../../domain/entities/tag.dart';
import '../../domain/repositories/api_tag_repository.dart';
import '../models/db_tag.dart';
import '../transformer/transformer.dart';
import 'api_provider/api_data_provider.dart';

class TagRepository extends ApiTagRepository {
  final ApiDataProvider _provider;

  TagRepository({
    required ApiDataProvider provider,
  }) : _provider = provider;

  @override
  Stream<List<Tag>> get tagsStream =>
      _provider.tagsStream.map<List<Tag>>(_transformToListTag);

  List<Tag> _transformToListTag(List<DBTag> dbTags) {
    final result = <Tag>[];
    for (final dbTag in dbTags) {
      result.add(Transformer.dbTagToEntity(dbTag));
    }
    return result;
  }

  @override
  Future<void> addTag(Tag tag) async {
    final dbTag = Transformer.tagToModel(tag);
    await _provider.addTag(dbTag);
  }

  @override
  Future<List<Tag>> getTags() async {
    final dbTags = await _provider.tags;
    final tags = List<Tag>.generate(dbTags.length, (index) {
      return Transformer.dbTagToEntity(dbTags[index]);
    });
    return tags;
  }

  @override
  Future<void> removeTag(Tag tag) async => await _provider.deleteTag(
        Transformer.tagToModel(tag),
      );

  @override
  Future<void> updateTag(Tag tag) async => await _provider.updateTag(
        Transformer.tagToModel(tag),
      );
}
