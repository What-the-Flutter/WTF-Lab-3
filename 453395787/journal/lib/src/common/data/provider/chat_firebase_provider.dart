import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/provider/chat_provider_api.dart';
import '../../extensions/snapshot_extension.dart';
import '../../models/db/db_chat.dart';
import '../../models/db/db_message.dart';
import '../../utils/app_logger.dart';
import '../../utils/typedefs.dart';
import 'database_references.dart';

class ChatFirebaseProvider
    with AppLogger, ChatsDatabaseReference, MessagesDatabaseReference
    implements ChatProviderApi {
  final String _userId;

  ChatFirebaseProvider({
    required String userId,
  }) : _userId = userId {
    _initChatStream();
    _initChatAndMessageSynchronization();
  }

  Future<void> _initChatStream() async {
    final event = await chatsRef(_userId).once(DatabaseEventType.value);
    _chatsSubject.add(
      event.snapshot.toModels(DbChat.fromJson),
    );

    chatsRef(_userId).onValue.listen(
      (event) {
        final chats = event.snapshot.toModels(DbChat.fromJson);
        log.v('Database -> new chats event -> $chats');
        _chatsSubject.add(chats);
      },
    );
  }

  void _initChatAndMessageSynchronization() {
    messagesRef(_userId).onValue.listen(
      (event) async {
        if (event.snapshot.exists) {
          final messages = event.snapshot.toModels(
            DbMessage.fromJson,
          );

          final messageGroups = messages.groupListsBy((e) => e.parentId);
          for (var group in messageGroups.entries) {
            final lastMessage = group.value.last;

            await chatsRef(_userId).child(lastMessage.parentId).update(
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

  final BehaviorSubject<DbChatList> _chatsSubject = BehaviorSubject.seeded(
    IList([]),
  );

  @override
  ValueStream<DbChatList> get chats => _chatsSubject.stream;

  @override
  Future<String> addChat(DbChat chat) async {
    final ref = chatsRef(_userId).push();
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
    await chatsRef(_userId).child(chat.id).update(chat.toJson());
  }

  @override
  Future<void> deleteChat(String chatId) async {
    final messages = (await messagesRef(_userId).get()).toModels(
      DbMessage.fromJson,
    );
    final chatMessages = messages.where(
      (e) => e.parentId == chatId,
    );

    for (var chatMessage in chatMessages) {
      await messagesRef(_userId).child(chatMessage.id).remove();
    }

    await chatsRef(_userId).child(chatId).remove();
  }
}
