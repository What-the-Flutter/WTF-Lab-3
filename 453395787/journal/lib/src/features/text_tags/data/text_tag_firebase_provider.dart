import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/extensions/snapshot_extension.dart';
import '../../../common/utils/app_logger.dart';
import '../api/text_tag_firebase_provider_api.dart';
import '../model/text_tag.dart';

class TextTagFirebaseProvider
    with AppLogger
    implements TextTagFirebaseProviderApi {
  final String _userId;

  TextTagFirebaseProvider({
    required String userId,
  }) : _userId = userId {
    _initTextTagsStream();
  }

  Future<void> _initTextTagsStream() async {
    final event = await _ref.once(DatabaseEventType.value);
    _textTagsSubject.add(
      event.snapshot.toModels(TextTag.fromJson),
    );
    _ref.onValue.listen(
      (event) {
        final chats = event.snapshot.toModels(TextTag.fromJson);
        log.v('Database -> new chats event -> $chats');
        _textTagsSubject.add(chats);
      },
    );
  }

  final BehaviorSubject<IList<TextTag>> _textTagsSubject =
      BehaviorSubject.seeded(
    IList<TextTag>([]),
  );

  @override
  ValueStream<IList<TextTag>> get textTags => _textTagsSubject.stream;

  @override
  Future<void> add(TextTag tag) async {
    final ref = _ref.push();

    await ref.set(
      tag.copyWith(id: ref.key!).toJson(),
    );
  }

  @override
  Future<void> delete(String id) async {
    await _ref.child(id).remove();
  }

  DatabaseReference get _ref =>
      FirebaseDatabase.instance.ref('users/$_userId/textTags');
}
