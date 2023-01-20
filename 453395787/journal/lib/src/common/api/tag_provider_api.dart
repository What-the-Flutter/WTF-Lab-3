import 'package:rxdart/rxdart.dart';

import '../models/tag.dart';
import '../utils/typedefs.dart';

abstract class TagProviderApi {
  ValueStream<TagList> get tags;

  Future<Id> addTag(Tag tag);

  Future<void> deleteTag(Id tagId);

  Future<void> updateTag(Tag tag);
}
