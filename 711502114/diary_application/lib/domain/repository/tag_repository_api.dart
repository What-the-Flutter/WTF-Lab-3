import 'package:diary_application/domain/models/tag.dart';

abstract class TagRepositoryApi {
  Stream<List<Tag>> get tagStream;

  Future<List<Tag>> get tags;

  Future<void> addTag(Tag tag);

  Future<void> updateTag(Tag tag);

  Future<void> deleteTag(Tag tag);
}