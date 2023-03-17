import '../entities/tag.dart';

abstract class ApiTagRepository {
  Future<void> addTag(Tag tag);

  Stream<List<Tag>> get tagsStream;

  Future<void> updateTag(Tag tag);

  Future<void> removeTag(Tag tag);

  Future<List<Tag>> getTags();
}
