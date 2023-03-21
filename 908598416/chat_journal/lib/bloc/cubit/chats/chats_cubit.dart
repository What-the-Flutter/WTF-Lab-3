import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/constants/constants.dart';
import '../../../data/models/chat.dart';
import '../../../data/providers/chat_provider.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._provider) : super(ChatsInitial());
  final ChatProvider _provider;

  int compare(Chat a, Chat b) {
    return _provider.compare(a, b);
  }

  Stream<QuerySnapshot<Object?>> getStreamFireStore(int limit, String userId, String? search) =>
      _provider.getStreamFireStore(
          FirestoreConstants.pathChatsCollection, limit, userId, search);

  void updateDataFirestore(String userId, Map<String, String> map) {
    _provider.updateDataFirestore(FirestoreConstants.pathUserCollection, userId, map);
  }

  void deleteChat(String currentUserId, String chatId) {
    _provider.deleteChat(currentUserId, chatId);
  }

  void pinChat(String currentUserId, String chatId) {
    _provider.pinChat(currentUserId, chatId);
  }

  void getInfo(BuildContext context, String userId, String chatId) {
    _provider.getInfo(context, userId, chatId);
  }

  void addChat(BuildContext context, String name, String currentUserId, int icon) {
    _provider.addChat(name, currentUserId, icon);
    Navigator.pop(context);
  }

  void updateChat(BuildContext context, String currentUserId, String chatId, String name, int icon) {
    _provider.updateChat(currentUserId, chatId, name, icon);
    Navigator.pop(context);
  }
}
