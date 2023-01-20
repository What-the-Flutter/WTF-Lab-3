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
    log.i('initialize');
    _userId = userId;
    _initTagsStream(userId);
    _initChatStream(userId);
    _initChatAndMessageSynchronization();
  }

  void _initChatAndMessageSynchronization() {
    _messagesRef.onValue.listen(
      (event) async {
        if (event.snapshot.exists) {
          final messages = _transformSnapshotToMessages(event.snapshot);
          final messageGroups = messages.groupListsBy((e) => e.parentId);
          for (var group in messageGroups.entries) {
            final lastMessage = group.value.last;
            log.wtf('In sync $group');

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

  void _initTagsStream(Id userId) {
    log.i('init Tags Stream');
    _tagsRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        final tags = _transformSnapshotToTags(event.snapshot);
        log.i('New tags: $tags');
        tagsSubject.add(tags);
      }
    });
  }

  TagList _transformSnapshotToTags(DataSnapshot snapshot) {
    final dynamicMap = snapshot.value as Map<dynamic, dynamic>;
    final tagsMap = dynamicMap.mapTo((key, value) => value).toIList();

    var tags = IList<DbTag>();
    for (Map<dynamic, dynamic> tagMap in tagsMap) {
      final m = tagMap.map(
        (key, value) {
          return MapEntry(key as String, value as Object?);
        },
      );
      tags = tags.add(
        DbTag.fromJson(m),
      );
    }

    return tags;
  }

  Future<void> _initChatStream(Id userId) async {
    log.i('init message Stream');
    _chatsRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        final chats = _transformSnapshotToChats(event.snapshot);
        log.i('New chats: $chats');
        chatsSubject.add(chats);
      } else {
        chatsSubject.add(IList([]));
      }
    });

    final event = await _chatsRef.once(DatabaseEventType.value);
    chatsSubject.add(_transformSnapshotToChats(event.snapshot));
  }

  ChatViewList _transformSnapshotToChats(DataSnapshot snapshot) {
    final dynamicMap = snapshot.value as Map<dynamic, dynamic>;
    final chatsMap = dynamicMap.mapTo((key, value) => value).toIList();

    var chats = IList<DbChat>();
    for (Map<dynamic, dynamic> chatMap in chatsMap) {
      final m = chatMap.map(
        (key, value) {
          return MapEntry(key as String, value as Object?);
        },
      );
      chats = chats.add(
        DbChat.fromJson(m),
      );
    }

    return chats;
  }

  BehaviorSubject<ChatViewList> chatsSubject = BehaviorSubject.seeded(
    IList([]),
  );

  BehaviorSubject<TagList> tagsSubject = BehaviorSubject.seeded(
    IList([]),
  );

  @override
  ValueStream<ChatViewList> get chats => chatsSubject.stream;

  @override
  ValueStream<TagList> get tags => tagsSubject.stream;

  @override
  Future<Id> addChat(DbChat chat) async {
    log.i('add Chat $chat');
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
    log.i('update Chat $chat');
    await _chatsRef.child(chat.id).update(chat.toJson());
  }

  @override
  Future<void> deleteChat(Id chatId) async {
    log.i('delete Chat $chatId');
    final messages = _transformSnapshotToMessages(
      await _messagesRef.get(),
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
  Future<void> deleteMessages(IList<Id> messagesId) async {
    messagesId.forEach(await deleteMessage);
  }

  @override
  ValueStream<MessageList> messagesOf({required Id chatId}) {
    log.i('messagesOf $chatId');
    return _messagesRef.onValue.map(
      (event) {
        log.i('messagesOf Event ${event.snapshot.value}');
        if (event.snapshot.exists) {
          final messages = _transformSnapshotToMessages(event.snapshot);
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

  MessageList _transformSnapshotToMessages(DataSnapshot snapshot) {
    final dynamicMap = snapshot.value as Map<dynamic, dynamic>;
    final messagesMap = dynamicMap.mapTo((key, value) => value).toIList();

    var messages = IList<DbMessage>();
    for (Map<dynamic, dynamic> messageMap in messagesMap) {
      final m = messageMap.map(
        (key, value) {
          return MapEntry(key as String, value as Object?);
        },
      );
      messages = messages.add(
        DbMessage.fromJson(m),
      );
    }

    return messages;
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
    await _tagsRef.push().set(tag.toJson());
  }

  @override
  Future<void> deleteTag(Id tagId) async {
    final tagRef = FirebaseDatabase.instance.ref('$_tagsRef/$tagId');
    await tagRef.remove();
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
