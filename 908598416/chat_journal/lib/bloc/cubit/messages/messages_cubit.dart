import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import '../../../data/constants/firestore_constants.dart';
import '../../../data/models/message.dart';
import '../../../data/providers/message_provider.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this._provider) : super(MessagesInitial());

  final MessageProvider _provider;

  Future<UploadTask> uploadFile(File file, String fileName) async =>
      _provider.uploadFile(file, fileName);

  Future<void> sendMessage(String content, int type, String chatId,
          String currentUserId) async =>
      _provider.sendMessage(content, type, chatId, currentUserId);

  Future<void> updateDataFirestore(String path,
          String docPath, Map<String, dynamic> map) async =>
      _provider.updateDataFirestore(
          path, docPath, map);

  Future<void> updateMessage(String currentUserId, String chatId,
          String currentMessageId, String value) async =>
      _provider.updateMessage(currentUserId, chatId, currentMessageId, value);

  Stream<QuerySnapshot<Object?>> getMessageStream(
          String currentUserId, String chatId, int limit, String? search) =>
      _provider.getMessageStream(currentUserId, chatId, limit, search);

  int compare(Message a, Message b) {
    return _provider.compare(a, b);
  }

  void pinMessage(
      String currentUserId, String chatId, String id, bool isPinned) {
    _provider.pinMessage(currentUserId, chatId, id, isPinned);
  }

  void deleteMessage(String currentUserId, String chatId, String id) {
    _provider.deleteMessage(currentUserId, chatId, id);
  }
}
