import '../entities/tag.dart';

abstract class TagRepository{
  Future<List<Tag>> getTags();

  Future<String> insertTag(Tag tag);

  Future<void> deleteTag(Tag tag);

  void initListener(Function updateTags);

  void disposeListener();
}