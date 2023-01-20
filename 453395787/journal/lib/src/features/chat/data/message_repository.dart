import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/api/message_provider_api.dart';
import '../../../common/api/tag_provider_api.dart';
import '../../../common/extensions/iterable_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../common/models/chat_view.dart';
import '../../../common/models/message.dart';
import '../../../common/utils/typedefs.dart';
import '../api/message_repository_api.dart';

class MessageRepository extends MessageRepositoryApi {
  MessageRepository({
    required MessageProviderApi messageProviderApi,
    required TagProviderApi tagProviderApi,
    required ChatView chat,
  })  : _messageProviderApi = messageProviderApi,
        _tagProviderApi = tagProviderApi,
        _chat = chat {
    _filteredChatStream.add(
      _messageProviderApi.messagesOf(
        chatId: chat.id,
      ),
    );

    _messagesStreamSubscription =
        _messageProviderApi.messagesOf(chatId: chat.id).listen(
      (event) {
        _filteredChatStream.add(
          _messageProviderApi.messagesOf(chatId: chat.id),
        );
      },
    );
  }

  final MessageProviderApi _messageProviderApi;
  final TagProviderApi _tagProviderApi;

  final ChatView _chat;

  @override
  ChatView get chat => _chat;

  @override
  ValueStream<TagList> get tags => _tagProviderApi.tags;

  final BehaviorSubject<ValueStream<MessageList>> _filteredChatStream =
      BehaviorSubject();

  late final StreamSubscription<MessageList> _messagesStreamSubscription;

  void close() {
    _messagesStreamSubscription.cancel();
    _filteredChatStream.close();
  }

  @override
  ValueStream<ValueStream<MessageList>> get filteredChatStreams =>
      _filteredChatStream.stream;

  @override
  Future<void> add(Message message) async {
    await customAdd(chat.id, message);
  }

  @override
  Future<void> customAdd(Id chatId, Message message) async {
    await _messageProviderApi.addMessage(chatId, message);
  }

  @override
  Future<void> addToFavorites(Message message) async {
    await _messageProviderApi.updateMessage(
      message.copyWith(isFavorite: true),
    );
  }

  @override
  Future<void> remove(Message message) async {
    await _messageProviderApi.deleteMessage(message.id);
  }

  @override
  Future<void> removeAll(MessageList messages) async {
    _messageProviderApi.deleteMessages(
      messages.map((message) => message.id).toIList(),
    );
  }

  @override
  Future<void> removeFromFavorites(Message message) async {
    await _messageProviderApi.updateMessage(
      message.copyWith(isFavorite: true),
    );
  }

  @override
  Future<void> update(Message message) async {
    await _messageProviderApi.updateMessage(message);
  }

  @override
  Future<void> search(String query, [TagList? tags]) async {
    _filteredChatStream.add(
      _applyFilter(
        _messageProviderApi.messagesOf(chatId: chat.id),
        query,
        tags,
      ),
    );
  }

  ValueStream<MessageList> _applyFilter(
    ValueStream<MessageList> messagesStream,
    String query, [
    TagList? tags,
  ]) {
    return messagesStream.map(
      (messages) {
        return _filterMessages(messages, query, tags);
      },
    ).shareValueSeeded(
      _filterMessages(messagesStream.value, query, tags),
    );
  }

  MessageList _filterMessages(
    MessageList messages,
    String query, [
    TagList? tags,
  ]) {
    return messages.where(
      (message) {
        if (tags == null) {
          return message.text.containsIgnoreCase(query);
        }
        return message.tagsId.containsAll(tags.map((e) => e.id)) &&
            message.text.containsIgnoreCase(query);
      },
    ).toIList();
  }
}
