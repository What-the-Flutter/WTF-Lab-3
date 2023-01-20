import 'package:rxdart/rxdart.dart';

import '../../models/db/db_tag.dart';
import '../../utils/typedefs.dart';

abstract class TagProviderApi {
  ValueStream<TagList> get tags;

  Future<Id> addTag(DbTag tag);

  Future<void> deleteTag(Id tagId);

  Future<void> updateTag(DbTag tag);
}
