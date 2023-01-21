import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/provider/chat_provider_api.dart';
import '../../api/provider/message_provider_api.dart';
import '../../api/provider/tag_provider_api.dart';
import '../../models/db/db_chat.dart';
import '../../models/db/db_message.dart';
import '../../models/db/db_tag.dart';
import '../../utils/typedefs.dart';

class Database implements ChatProviderApi, MessageProviderApi, TagProviderApi {
  static Id _userId = '';

  static Logger log = Logger();

  Database({required Id userId}) {
    _userId = userId;
    _initTagsStream();
    _initChatStream();
    _initChatAndMessageSynchronization();
  }

  Future<void> _initTagsStream() async {
    final event = await _tagsRef.once(DatabaseEventType.value);
    _tagsSubject.add(
      _snapshotToModels(event.snapshot, DbTag.fromJson),
    );

    _tagsRef.onValue.listen(
      (event) {
        final tags = _snapshotToModels(event.snapshot, DbTag.fromJson);
        log.v('Database -> new tags event -> $tags');
        _tagsSubject.add(tags);
      },
    );
  }

  Future<void> _initChatStream() async {
    final event = await _chatsRef.once(DatabaseEventType.value);
    _chatsSubject.add(
      _snapshotToModels(event.snapshot, DbChat.fromJson),
    );

    _chatsRef.onValue.listen(
      (event) {
        final chats = _snapshotToModels(event.snapshot, DbChat.fromJson);
        log.v('Database -> new chats event -> $chats');
        _chatsSubject.add(chats);
      },
    );
  }

  void _initChatAndMessageSynchronization() {
    _messagesRef.onValue.listen(
      (event) async {
        if (event.snapshot.exists) {
          final messages = _snapshotToModels(
            event.snapshot,
            DbMessage.fromJson,
          );

          final messageGroups = messages.groupListsBy((e) => e.parentId);
          for (var group in messageGroups.entries) {
            final lastMessage = group.value.last;

            await _chatsRef.child(lastMessage.parentId).update(
              {
                'messagePreview': lastMessage.text,
                'messagePreviewCreationTime':
                    lastMessage.dateTime.toIso8601String(),
                'messageAmount': group.value.length,
              },
            );
          }
        }
      },
    );
  }

  IList<E> _snapshotToModels<E>(
    DataSnapshot snapshot,
    E Function(Map<String, Object?>) transformer,
  ) {
    if (!snapshot.exists) {
      return IList([]);
    }

    final dynamicMap = snapshot.value as Map<dynamic, dynamic>;
    final listOfMaps = dynamicMap.mapTo((key, value) => value).toIList();

    var models = IList<E>();
    for (Map<dynamic, dynamic> map in listOfMaps) {
      final modelMap = map.map(
        (key, value) => MapEntry(key as String, value as Object?),
      );
      models = models.add(
        transformer(modelMap),
      );
    }
    return models;
  }

  final BehaviorSubject<DbChatList> _chatsSubject = BehaviorSubject.seeded(
    IList([]),
  );

  final BehaviorSubject<DbTagList> _tagsSubject = BehaviorSubject.seeded(
    IList([]),
  );

  @override
  ValueStream<DbChatList> get chats => _chatsSubject.stream;

  @override
  ValueStream<DbTagList> get tags => _tagsSubject.stream;

  @override
  Future<Id> addChat(DbChat chat) async {
    final ref = _chatsRef.push();
    await ref.set(
      chat
          .copyWith(
            id: ref.key!,
          )
          .toJson(),
    );
    return ref.key!;
  }

  @override
  Future<void> updateChat(DbChat chat) async {
    await _chatsRef.child(chat.id).update(chat.toJson());
  }

  @override
  Future<void> deleteChat(Id chatId) async {
    final messages = _snapshotToModels(
      await _messagesRef.get(),
      DbMessage.fromJson,
    );
    final chatMessages = messages.where(
      (e) => e.parentId == chatId,
    );

    for (var chatMessage in chatMessages) {
      await _messagesRef.child(chatMessage.id).remove();
    }

    await _chatsRef.child(chatId).remove();
  }

  @override
  Future<Id> addMessage(Id chatId, DbMessage message) async {
    final ref = _messagesRef.push();
    await ref.set(
      message
          .copyWith(
            id: ref.key!,
            parentId: chatId,
          )
          .toJson(),
    );
    return ref.key!;
  }

  @override
  Future<void> updateMessage(DbMessage message) async {
    await _messagesRef.child(message.id).update(
          message.toJson(),
        );
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await _messagesRef.child(messageId).remove();
  }

  @override
  Future<void> deleteMessages(Iterable<Id> messagesId) async {
    messagesId.forEach(await deleteMessage);
  }

  @override
  ValueStream<DbMessageList> messagesOf({required Id chatId}) {
    return _messagesRef.onValue.map(
      (event) {
        log.v(
            'Database -> messagesOf $chatId -> Event ${event.snapshot.value}');
        if (event.snapshot.exists) {
          final messages = _snapshotToModels(
            event.snapshot,
            DbMessage.fromJson,
          );

          return messages
              .where(
                (e) => e.parentId == chatId,
              )
              .sorted((a, b) => a.dateTime.compareTo(b.dateTime))
              .toIList();
        }
        return IList<DbMessage>([]);
      },
    ).shareValueSeeded(
      IList([]),
    );
  }

  @override
  Future<Id> addTag(DbTag tag) async {
    final ref = _tagsRef.push();
    ref.set(
      tag.copyWith(id: ref.key!).toJson(),
    );
    return ref.key!;
  }

  @override
  Future<void> updateTag(DbTag tag) async {
    await _tagsRef.child(tag.id).update(tag.toJson());
  }

  @override
  Future<void> deleteTag(Id tagId) async {
    await _tagsRef.child(tagId).remove();
  }

  DatabaseReference get _usersRef {
    return FirebaseDatabase.instance.ref('users/$_userId');
  }

  DatabaseReference get _chatsRef {
    return FirebaseDatabase.instance.ref('users/$_userId/chats');
  }

  DatabaseReference get _tagsRef {
    return FirebaseDatabase.instance.ref('users/$_userId/tags');
  }

  DatabaseReference get _messagesRef {
    return FirebaseDatabase.instance.ref('users/$_userId/messages');
  }
}
