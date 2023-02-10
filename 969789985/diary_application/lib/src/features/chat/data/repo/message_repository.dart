import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/models/tag_model.dart';
import '../../../chat_list/domain/chat_model.dart';
import '../../domain/message_model.dart';
import '../interfaces/message_provider_interface.dart';
import '../interfaces/message_repository_interface.dart';

class MessageRepository extends MessageRepositoryInterface {
  MessageRepository({
    required MessageProviderInterface provider,
    required this.chatId,
  }) : _provider = provider {
    _rxChatStream.add(
      _provider.messages(chatId: chatId),
    );

    _sub = _provider.messages(chatId: chatId).listen(
      (event) {
        _rxChatStream.add(_provider.messages(chatId: chatId));
      },
    );
  }

  final MessageProviderInterface _provider;
  final int chatId;

  final BehaviorSubject<ValueStream<IList<MessageModel>>> _rxChatStream =
      BehaviorSubject();
  late final StreamSubscription<IList<MessageModel>> _sub;

  @override
  ValueStream<ValueStream<IList<MessageModel>>> get rxChatStreams =>
      _rxChatStream.stream;

  @override
  ValueStream<IList<TagModel>> get tags => _provider.tags;

  @override
  Future<void> addMessage(MessageModel message) async =>
      _provider.addMessage(message, chatId);

  @override
  Future<int> updateMessage(MessageModel message) async =>
      await _provider.updateMessage(message);

  @override
  Future<void> deleteMessage(MessageModel message) async =>
      _provider.deleteMessage(message.id);

  @override
  Future<void> deleteSelected(
    IList<MessageModel> messages,
    IMap<int, bool> selected,
  ) async {
    _provider.deleteSelected(messages, selected);
  }

  @override
  Future<void> addTag(TagModel tag) async => _provider.addTag(tag);

  @override
  Future<void> removeTag(TagModel tag) async => _provider.removeTag(tag);

  @override
  Future<void> addToFavorites(MessageModel message) async =>
      _provider.updateMessage(
        message.copyWith(isFavorite: true),
      );

  @override
  Future<void> removeFromFavorites(MessageModel message) async =>
      _provider.updateMessage(
        message.copyWith(isFavorite: false),
      );

  ChatModel _findByIndex(IList<ChatModel> chats, int id) {
    return chats.firstWhere((chat) => chat.id == id);
  }
}
