import 'package:rxdart/rxdart.dart';

import '../../models/ui/tag.dart';
import '../../utils/typedefs.dart';

abstract class TagRepositoryApi {
  ValueStream<TagList> get tags;

  Future<String> addTag(Tag tag);

  Future<void> deleteTag(String tagId);

  Future<void> updateTag(Tag tag);
}
