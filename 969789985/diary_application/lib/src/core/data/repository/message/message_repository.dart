import 'dart:async';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/api/message/api_message_provider.dart';
import '../../../domain/api/message/api_message_repository.dart';
import '../../../domain/api/storage/api_storage_provider.dart';
import '../../../domain/api/tag/api_tag_provider.dart';
import '../../../domain/models/local/chat/chat_model.dart';
import '../../../domain/models/local/message/message_model.dart';
import '../../../domain/models/local/tag/tag_model.dart';
import '../../../util/typedefs.dart';

class MessageRepository extends ApiMessageRepository {
  MessageRepository({
    required ApiMessageProvider provider,
    required ApiStorageProvider storageProvider,
    required ApiTagProvider tagProvider,
    required ChatModel currentChat,
  })  : _provider = provider,
        _storageProvider = storageProvider,
        _tagProvider = tagProvider,
        _currentChat = currentChat;

  final ApiMessageProvider _provider;
  final ApiStorageProvider _storageProvider;
  final ApiTagProvider _tagProvider;
  final ChatModel _currentChat;

  FId get currentChatId => _currentChat.id;

  @override
  ValueStream<IList<MessageModel>> get rxChatStreams => _provider
      .messages(chatId: currentChatId)
      .transform(
        _provider.messageStreamTransform(_fetchFile, _tag),
      )
      .shareValueSeeded(IList([]));

  @override
  Future<void> addMessage(MessageModel message) async =>
      await _provider.addMessage(
        currentChatId,
        await _provider.firebaseMessage(
          currentChatId,
          message,
        ),
      );

  @override
  Future<void> updateMessage(MessageModel message) async =>
      await _provider.updateMessage(
        await _provider.firebaseMessage(
          currentChatId,
          message,
        ),
      );

  @override
  Future<void> deleteMessage(MessageModel message) async =>
      await _provider.deleteMessage(message.id);

  @override
  Future<void> deleteSelected(
    IList<MessageModel> messages,
  ) async {
    await _provider.deleteSelectedMessages(messages.map((e) => e.id).toList());
  }

  @override
  Future<void> addToFavorites(IList<MessageModel> messages) async {
    for(final message in messages) {
      await _provider.updateMessage(
        await _provider.firebaseMessage(
          currentChatId,
          message.copyWith(
            isFavorite: true,
          ),
        ),
      );
    }
  }


  @override
  Future<void> removeFromFavorites(IList<MessageModel> messages) async {
    for(final message in messages) {
      await _provider.updateMessage(
        await _provider.firebaseMessage(
          currentChatId,
          message.copyWith(
            isFavorite: false,
          ),
        ),
      );
    }
  }

  TagModel _tag(FId id) {
    final firebaseTag =
        _tagProvider.tags.value.firstWhere((tag) => tag.id == id);

    return _tagProvider.tag(firebaseTag);
  }

  Future<File> _fetchFile(String filename) async =>
      _storageProvider.loadImage(filename);
}
