import 'package:diary_application/data/converter/converter_db.dart';
import 'package:diary_application/data/entities/tag_db.dart';
import 'package:diary_application/data/provider/api_firebase_provider.dart';
import 'package:diary_application/domain/models/tag.dart';
import 'package:diary_application/domain/repository/tag_repository_api.dart';

class TagRepository extends TagRepositoryApi {
  final ApiDataProvider _provider;

  TagRepository({required ApiDataProvider provider}) : _provider = provider;

  @override
  Future<void> addTag(Tag tag) async =>
      await _provider.addTag(ConverterDB.tag2Entity(tag));

  @override
  Future<void> deleteTag(Tag tag) async =>
      await _provider.deleteTag(ConverterDB.tag2Entity(tag));

  @override
  Stream<List<Tag>> get tagStream =>
      _provider.tagsStream.map<List<Tag>>(_toListTag).asBroadcastStream();

  List<Tag> _toListTag(List<TagDB> tags) {
    final tagsList = <Tag>[];
    for (final tag in tags) {
      tagsList.add(ConverterDB.entity2Tag(tag));
    }
    return tagsList;
  }

  @override
  Future<List<Tag>> get tags => _getTags();

  Future<List<Tag>> _getTags() async {
    final tagsDB = await _provider.tags;
    return List<Tag>.generate(tagsDB.length, (i) {
      return ConverterDB.entity2Tag(tagsDB[i]);
    });
  }

  @override
  Future<void> updateTag(Tag tag) async =>
      await _provider.updateTag(ConverterDB.tag2Entity(tag));
}
