import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/api/message/api_message_provider.dart';
import '../../../domain/models/firebase/message/firebase_message_model.dart';
import '../../../domain/models/local/message/message_model.dart';
import '../../../util/extension/snapshot_extension.dart';
import '../../../util/typedefs.dart';
import '../converter/tag_converter.dart';
import '../reference/message_reference.dart';

class MessageSource extends MessageReference
    with TagConverter
    implements ApiMessageProvider {
  final FId _firebaseUserId;

  MessageSource({
    required FId firebaseUserId,
  }) : _firebaseUserId = firebaseUserId;

  @override
  FId get firebaseUserId => _firebaseUserId;

  @override
  ValueStream<IList<FirebaseMessageModel>> messages({
    required FId chatId,
  }) {
    messagesReference.keepSynced(true);

    return messagesReference.onValue.map(
      (event) {
        if (event.snapshot.exists) {
          final messages = event.snapshot.toModels(
            FirebaseMessageModel.fromJson,
          );

          return messages
              .where((mes) => mes.chatId == chatId)
              .toIList()
              .sort((compF, compS) => compF.sendDate.compareTo(compS.sendDate));
        }
        return IList<FirebaseMessageModel>([]);
      },
    ).shareValueSeeded(
      IList(),
    );
  }

  @override
  Future<FId> addMessage(FId chatId, FirebaseMessageModel message) async {
    final reference = messagesReference.push();

    reference.set(
      message.copyWith(id: reference.key!, chatId: chatId).toJson(),
    );

    return reference.key!;
  }

  @override
  Future<void> deleteMessage(FId messageId) async =>
      await messagesReference.child(messageId).remove();

  @override
  Future<void> deleteSelectedMessages(List<FId> messagesId) async {
    for (final id in messagesId) {
      await deleteMessage(id);
    }
  }

  @override
  Future<void> updateMessage(FirebaseMessageModel message) async =>
      await messagesReference.child(message.id).update(
            message.toJson(),
          );

  @override
  StreamTransformer<IList<FirebaseMessageModel>, IList<MessageModel>>
      messageStreamTransform(
    FileFromFuture fetchFile,
    TagFromFirebase tag,
  ) =>
          StreamTransformer<IList<FirebaseMessageModel>,
              IList<MessageModel>>.fromHandlers(
            handleData: (value, sink) {
              dev.log('$value', name: 'Message_transform_value');
              sink.add(
                messagesList(value, fetchFile, tag),
              );
            },
          );

  @override
  IList<MessageModel> messagesList(
    IList<FirebaseMessageModel> availableMessages,
    FileFromFuture fetchFile,
    TagFromFirebase tag,
  ) =>
      availableMessages
          .map(
            (fModel) => message(
              fModel,
              fetchFile,
              tag,
            ),
          )
          .toIList();

  @override
  MessageModel message(
    FirebaseMessageModel availableMessage,
    FileFromFuture fetchFile,
    TagFromFirebase tag,
  ) {
    return MessageModel(
      id: availableMessage.id,
      messageText: availableMessage.messageText,
      sendDate: availableMessage.sendDate,
      tags: availableMessage.tagsIds.map(tag).toIList(),
      images: availableMessage.imagePaths.map(fetchFile).toIList(),
      isFavorite: availableMessage.isFavorite,
    );
  }

  @override
  Future<FirebaseMessageModel> firebaseMessage(
    FId chatId,
    MessageModel message,
  ) async {
    final imagePaths = <String>[];

    for (final image in message.images) {
      imagePaths.add(
        basename((await image).path),
      );
    }

    return await FirebaseMessageModel(
        id: message.id,
        chatId: chatId,
        messageText: message.messageText,
        sendDate: message.sendDate,
        tagsIds: toFirebaseTagModel(message.tags),
        imagePaths: imagePaths.toIList(),
        isFavorite: message.isFavorite);
  }
}
