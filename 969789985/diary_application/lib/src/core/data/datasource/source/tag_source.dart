import 'dart:async';
import 'dart:developer' as dev;

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/db/tag/firebase_tag_model.dart';
import '../../../domain/models/local/tag/tag_model.dart';
import '../../../domain/provider/tag/api_tag_provider.dart';
import '../../../util/extension/snapshot_extension.dart';
import '../../../util/typedefs.dart';
import '../reference/tag_reference.dart';

class TagSource extends TagReference implements ApiTagProvider {
  final FId _firebaseUserId;

  TagSource({
    required FId firebaseUserId,
  }) : _firebaseUserId = firebaseUserId {
    _initializeTagsStream();
  }

  @override
  FId get firebaseUserId => _firebaseUserId;

  @override
  ValueStream<IList<FirebaseTagModel>> get tags => _tags.stream;

  @override
  Future<FId> addTag(FirebaseTagModel tag) async {
    final reference = tagsReference.push();

    reference.set(
      tag.copyWith(id: reference.key!).toJson(),
    );

    return reference.key!;
  }

  @override
  Future<void> deleteTag(FId tagId) async =>
      await tagsReference.child(tagId).remove();

  @override
  StreamTransformer<
      IList<FirebaseTagModel>,
      IList<
          TagModel>> get tagStreamTransform =>
      StreamTransformer<IList<FirebaseTagModel>, IList<TagModel>>.fromHandlers(
        handleData: (value, sink) {
          dev.log('$value', name: 'Tags_transform_value');
          sink.add(
            tagsList(value),
          );
        },
      );

  @override
  IList<TagModel> tagsList(IList<FirebaseTagModel> availableTags) {
    return availableTags.map(tag).toIList();
  }

  @override
  TagModel tag(FirebaseTagModel availableTag) => TagModel(
        id: availableTag.id,
        tagTitle: availableTag.tagTitle,
        tagIcon: availableTag.tagIcon,
      );

  @override
  FirebaseTagModel firebaseTagModel(TagModel tag) => FirebaseTagModel(
        tagTitle: tag.tagTitle,
        tagIcon: tag.tagIcon,
      );

  final BehaviorSubject<IList<FirebaseTagModel>> _tags = BehaviorSubject.seeded(
    IList<FirebaseTagModel>([]),
  );

  Future<void> _initializeTagsStream() async {
    tagsReference.keepSynced(true);
    final availableTags = await tagsReference.once(DatabaseEventType.value);

    _tags.add(
      availableTags.snapshot.toModels(FirebaseTagModel.fromJson),
    );

    tagsReference.onValue.listen(
      (event) {
        final tags = event.snapshot.toModels(FirebaseTagModel.fromJson);

        dev.log('From Firebase: $tags', name: 'Firebase_tags');

        _tags.add(tags);
      },
    );
  }
}
