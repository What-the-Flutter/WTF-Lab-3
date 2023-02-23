import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../util/typedefs.dart';
import '../../models/firebase/message/firebase_message_model.dart';
import '../../models/local/message/message_model.dart';

abstract class ApiMessageProvider {
  ValueStream<IList<FirebaseMessageModel>> messages({required FId chatId});

  Future<FId> addMessage(FId chatId, FirebaseMessageModel message);

  Future<void> deleteMessage(FId messageId);

  Future<void> deleteSelectedMessages(List<FId> messagesId);

  Future<void> updateMessage(FirebaseMessageModel message);

  StreamTransformer<IList<FirebaseMessageModel>, IList<MessageModel>>
  messageStreamTransform(
      FileFromFuture fetchFile,
      TagFromFirebase tag,
      );

  IList<MessageModel> messagesList(
    IList<FirebaseMessageModel> availableMessages,
    FileFromFuture fetchFile,
    TagFromFirebase tag,
  );

  MessageModel message(
    FirebaseMessageModel availableMessage,
    FileFromFuture fetchFile,
    TagFromFirebase tag,
  );

  Future<FirebaseMessageModel> firebaseMessage(
      FId chatId, MessageModel message);
}
