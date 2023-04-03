import '../../domain/entities/tag.dart';
import '../../domain/repos/tag_repository.dart';
import '../entities/tag_dto.dart';
import '../services/database_service.dart';

class TagRepositoryImpl extends TagRepository {
  final DataBaseService dataBaseService;

  TagRepositoryImpl({required this.dataBaseService});

  @override
  Future<List<Tag>> getTags() async {
    final keys = <String>[];
    final raw = await dataBaseService.queryAllTags(keys);
    final tags = raw.map((event) => TagDTO.fromJSON(event).toModel()).toList();
    for (var i = 0; i < tags.length; i++) {
      tags[i] = tags[i].copyWith(id: keys[i]);
    }
    return tags;
  }

  @override
  Future<String> insertTag(Tag tag) async {
    final tagDTO = TagDTO(name: tag.name);
    await dataBaseService.insertTag(tagDTO.toJson());
    return tag.name;
  }

  @override
  Future<void> deleteTag(Tag tag) async {
    dataBaseService.deleteTag(tag.id!);
  }

  @override
  void initListener(Function updateTags) {
    dataBaseService.databaseRef
        .child(dataBaseService.fireBaseAuth.currentUser!.uid)
        .child('tags')
        .onValue
        .listen((tag) {
      updateTags();
    });
  }
}
