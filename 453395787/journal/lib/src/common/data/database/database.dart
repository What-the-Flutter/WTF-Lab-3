import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/chat_provider_api.dart';
import '../../api/message_provider_api.dart';
import '../../api/tag_provider_api.dart';
import '../../models/chat_view.dart';
import '../../models/message.dart';
import '../../models/tag.dart';
import '../../utils/typedefs.dart';

class Database implements ChatProviderApi, MessageProviderApi, TagProviderApi {
  static Id _userId = '';

  static Logger log = Logger();

  Database({required Id userId}) {
    log.i('initialize');
    _userId = userId;
    _initTagsStream(userId);
    _initChatStream(userId);
  }

  void _initTagsStream(Id userId) {
    log.i('init Tags Stream');
    _tagsRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        final tags = _transformEventToTag(event);
        log.i('New tags: $tags');
        tagsSubject.add(tags);
      }
    });
  }

  TagList _transformEventToTag(DatabaseEvent event) {
    final dynamicMap = event.snapshot.value as Map<dynamic, dynamic>;
    final tagsMap = dynamicMap.mapTo((key, value) => value).toIList();

    var tags = IList<Tag>();
    for (Map<dynamic, dynamic> tagMap in tagsMap) {
      final m = tagMap.map(
        (key, value) {
          return MapEntry(key as String, value as Object?);
        },
      );
      tags = tags.add(
        Tag.fromJson(m),
      );
    }

    return tags;
  }

  Future<void> _initChatStream(Id userId) async {
    log.i('init message Stream');
    _chatsRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        final chats = _transformEventToChatView(event);
        log.i('New chats: $chats');
        chatsSubject.add(chats);
      }
    });

    final event = await _chatsRef.once(DatabaseEventType.value);
    chatsSubject.add(_transformEventToChatView(event));
  }

  ChatViewList _transformEventToChatView(DatabaseEvent event) {
    final dynamicMap = event.snapshot.value as Map<dynamic, dynamic>;
    final chatsMap = dynamicMap.mapTo((key, value) => value).toIList();

    var chats = IList<ChatView>();
    for (Map<dynamic, dynamic> chatMap in chatsMap) {
      final m = chatMap.map(
        (key, value) {
          return MapEntry(key as String, value as Object?);
        },
      );
      chats = chats.add(
        ChatView.fromJson(m),
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
  Future<Id> addChat(ChatView chat) async {
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
  Future<void> updateChat(ChatView chat) async {
    log.i('update Chat $chat');
    await _chatsRef.push().update(chat.toJson());
  }

  @override
  Future<void> deleteChat(Id chatId) async {
    log.i('delete Chat $chatId');
    final chatsRef =
        FirebaseDatabase.instance.ref('user/$_userId/chats/$chatId');
    await chatsRef.remove();
  }

  @override
  Future<Id> addMessage(Id chatId, Message message) async {
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
  Future<void> updateMessage(Message message) async {
    final messageRef = FirebaseDatabase.instance.ref(
      '$_messagesRef/${message.id}',
    );
    await messageRef.update(message.toJson());
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    final messageRef = FirebaseDatabase.instance.ref(
      '$_messagesRef/$messageId',
    );
    await messageRef.remove();
  }

  @override
  Future<void> deleteMessages(IList<Id> messagesId) async {
    messagesId.forEach(await deleteMessage);
  }

  @override
  ValueStream<MessageList> messagesOf({required Id chatId}) {
    log.i('messagesOf $chatId');
    return _messagesRef.orderByChild('dateTime').onValue.map((event) {
      log.i('messagesOf Event ${event.snapshot.value}');
      if (event.snapshot.exists) {
        final messages = _transformEventToMessage(event);
        return messages
            .where(
              (e) => e.parentId == chatId,
            )
            .toIList();
      }
      return IList<Message>([]);
    }).shareValueSeeded(
      IList([]),
    );
  }

  MessageList _transformEventToMessage(DatabaseEvent event) {
    final dynamicMap = event.snapshot.value as Map<dynamic, dynamic>;
    final messagesMap = dynamicMap.mapTo((key, value) => value).toIList();

    var messages = IList<Message>();
    for (Map<dynamic, dynamic> messageMap in messagesMap) {
      final m = messageMap.map(
        (key, value) {
          return MapEntry(key as String, value as Object?);
        },
      );
      messages = messages.add(
        Message.fromJson(m),
      );
    }

    return messages;
  }

  @override
  Future<Id> addTag(Tag tag) async {
    final ref = _tagsRef.push();
    ref.set(
      tag.copyWith(id: ref.key!).toJson(),
    );
    return ref.key!;
  }

  @override
  Future<void> updateTag(Tag tag) async {
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
