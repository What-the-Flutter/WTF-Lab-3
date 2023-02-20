import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../util/typedefs.dart';
import '../../models/local/tag/tag_model.dart';

abstract class ApiTagRepository {
  ValueStream<IList<TagModel>> get tagsStream;

  Future<FId> addTag(TagModel tag);

  Future<void> deleteTag(String id);
}