import 'package:rxdart/rxdart.dart';

import '../../models/db/db_tag.dart';
import '../../utils/typedefs.dart';

abstract class TagProviderApi {
  ValueStream<DbTagList> get tags;

  Future<String> addTag(DbTag tag);

  Future<void> deleteTag(String tagId);

  Future<void> updateTag(DbTag tag);
}
