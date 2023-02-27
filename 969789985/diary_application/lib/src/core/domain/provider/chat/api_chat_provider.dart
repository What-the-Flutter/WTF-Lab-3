import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../util/typedefs.dart';
import '../../models/db/chat/firebase_chat_model.dart';
import '../../models/local/chat/chat_model.dart';

abstract class ApiChatProvider {
  ValueStream<IList<FirebaseChatModel>> get chats;

  StreamTransformer<IList<FirebaseChatModel>, IList<ChatModel>> get chatsStreamTransform;

  Future<FId> addChat(FirebaseChatModel chat);

  Future<void> deleteChat(FId chatId);

  Future<void> updateChat(FirebaseChatModel chat);

  IList<ChatModel> chatsList(IList<FirebaseChatModel> availableChats);

  ChatModel chat(FirebaseChatModel availableChat);

  FirebaseChatModel firebaseChat(ChatModel chat);
}