import 'dart:async';
import 'dart:developer' as dev;

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/db/chat/firebase_chat_model.dart';
import '../../../domain/models/local/chat/chat_model.dart';
import '../../../domain/provider/chat/api_chat_provider.dart';
import '../../../util/extension/snapshot_extension.dart';
import '../../../util/typedefs.dart';
import '../reference/chat_reference.dart';

class ChatSource extends ChatReference implements ApiChatProvider {
  final FId _firebaseUserId;

  ChatSource({
    required FId firebaseUserId,
  }) : _firebaseUserId = firebaseUserId {
    _initializeChatsStream();
  }

  @override
  FId get firebaseUserId => _firebaseUserId;

  @override
  ValueStream<IList<FirebaseChatModel>> get chats => _chats.stream;

  @override
  Future<FId> addChat(FirebaseChatModel chat) async {
    final reference = chatsReference.push();

    await reference.set(
      chat.copyWith(id: reference.key!).toJson(),
    );

    return reference.key!;
  }

  @override
  Future<void> deleteChat(FId chatId) async {
    await chatsReference.child(chatId).remove();
  }

  @override
  Future<void> updateChat(FirebaseChatModel chat) async {
    await chatsReference.child(chat.id).update(chat.toJson());
  }

  @override
  StreamTransformer<IList<FirebaseChatModel>, IList<ChatModel>>
      get chatsStreamTransform => StreamTransformer<IList<FirebaseChatModel>,
              IList<ChatModel>>.fromHandlers(
            handleData: (value, sink) {
              dev.log('$value', name: 'Chats_transform_value');
              sink.add(
                chatsList(value),
              );
            },
          );

  @override
  IList<ChatModel> chatsList(IList<FirebaseChatModel> availableChats) {
    return availableChats.map(chat).toIList();
  }

  @override
  ChatModel chat(FirebaseChatModel availableChat) => ChatModel(
        id: availableChat.id,
        chatTitle: availableChat.chatTitle,
        chatIcon: availableChat.chatIcon,
        creationDate: availableChat.creationDate,
        isPinned: availableChat.isPinned,
        isArchive: availableChat.isArchive,
      );

  @override
  FirebaseChatModel firebaseChat(ChatModel chat) => FirebaseChatModel(
        id: chat.id.toString(),
        chatTitle: chat.chatTitle,
        creationDate: chat.creationDate,
        chatIcon: chat.chatIcon,
      );

  final BehaviorSubject<IList<FirebaseChatModel>> _chats =
  BehaviorSubject.seeded(
    IList<FirebaseChatModel>([]),
  );

  Future<void> _initializeChatsStream() async {
    chatsReference.keepSynced(true);
    final availableChats = await chatsReference.once(DatabaseEventType.value);

    _chats.add(
      availableChats.snapshot.toModels(FirebaseChatModel.fromJson),
    );

    chatsReference.onValue.listen(
          (event) {
        final chat = event.snapshot.toModels(FirebaseChatModel.fromJson);
        _chats.add(
          chat.sort(
                (a, b) => a.creationDate.compareTo(b.creationDate),
          ),
        );
      },
    );
  }

}
