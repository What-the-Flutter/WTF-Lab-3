import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../util/typedefs.dart';
import '../../models/db/tag/firebase_tag_model.dart';
import '../../models/local/tag/tag_model.dart';

abstract class ApiTagProvider {
  ValueStream<IList<FirebaseTagModel>> get tags;

  StreamTransformer<IList<FirebaseTagModel>, IList<TagModel>>
      get tagStreamTransform;

  Future<FId> addTag(FirebaseTagModel tag);

  Future<void> deleteTag(FId tagId);

  IList<TagModel> tagsList(IList<FirebaseTagModel> availableTags);

  TagModel tag(FirebaseTagModel availableTag);

  FirebaseTagModel firebaseTagModel(TagModel tag);
}
