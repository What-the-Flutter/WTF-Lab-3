import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/provider/tag_provider_api.dart';
import '../../extensions/snapshot_extension.dart';
import '../../models/db/db_tag.dart';
import '../../utils/app_logger.dart';
import '../../utils/typedefs.dart';

class TagFirebaseProvider with AppLogger implements TagProviderApi {
  final String _userId;

  TagFirebaseProvider({
    required String userId,
  }) : _userId = userId {
    _initTagsStream();
  }

  Future<void> _initTagsStream() async {
    final event = await tagsRef.once(DatabaseEventType.value);
    _tagsSubject.add(
      event.snapshot.toModels(DbTag.fromJson),
    );

    tagsRef.onValue.listen(
      (event) {
        final tags = event.snapshot.toModels(DbTag.fromJson);
        log.v('Database -> new tags event -> $tags');
        _tagsSubject.add(tags);
      },
    );
  }

  final BehaviorSubject<DbTagList> _tagsSubject = BehaviorSubject.seeded(
    IList([]),
  );

  @override
  ValueStream<DbTagList> get tags => _tagsSubject.stream;

  @override
  Future<String> addTag(DbTag tag) async {
    final ref = tagsRef.push();
    ref.set(
      tag.copyWith(id: ref.key!).toJson(),
    );
    return ref.key!;
  }

  @override
  Future<void> updateTag(DbTag tag) async {
    await tagsRef.child(tag.id).update(tag.toJson());
  }

  @override
  Future<void> deleteTag(String tagId) async {
    await tagsRef.child(tagId).remove();
  }

  DatabaseReference get tagsRef =>
      FirebaseDatabase.instance.ref('users/$_userId/tags');
}
