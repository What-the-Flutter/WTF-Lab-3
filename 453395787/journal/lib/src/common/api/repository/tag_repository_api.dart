
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/ui/tag.dart';
import '../../utils/typedefs.dart';

abstract class TagRepositoryApi {
  ValueStream<IList<Tag>> get tags;

  Future<Id> addTag(Tag tag);

  Future<void> deleteTag(Id tagId);

  Future<void> updateTag(Tag tag);
}