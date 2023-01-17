import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/api/message_provider_api.dart';
import '../../../common/extensions/iterable_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../common/models/chat_view.dart';
import '../../../common/models/message.dart';
import '../../../common/utils/typedefs.dart';
import '../api/message_repository_api.dart';

class MessageRepository extends MessageRepositoryApi {
  MessageRepository({
    required MessageProviderApi repository,
    required ChatView chat,
  })  : _repository = repository,
        _chat = chat {
    _filteredChatStream.add(
      _repository.messagesOf(
        chatId: chat.id,
      ),
    );

    _subscription = _repository.messagesOf(chatId: chat.id).listen(
      (event) {
        _filteredChatStream.add(
          _repository.messagesOf(chatId: chat.id),
        );
      },
    );
  }

  final MessageProviderApi _repository;

  final ChatView _chat;

  @override
  ChatView get chat => _chat;

  @override
  ValueStream<TagList> get tags => _repository.tags;

  final BehaviorSubject<ValueStream<MessageList>> _filteredChatStream =
      BehaviorSubject();

  late final StreamSubscription<MessageList> _subscription;

  void close() {
    _subscription.cancel();
    _filteredChatStream.close();
  }

  @override
  ValueStream<ValueStream<MessageList>> get filteredChatStreams =>
      _filteredChatStream.stream;

  @override
  Future<void> add(Message message) async {
    await _repository.addMessage(chat.id, message);
  }

  @override
  Future<void> customAdd(int chatId, Message message) async {
    await _repository.addMessage(chatId, message);
  }

  @override
  Future<void> addToFavorites(Message message) async {
    await _repository.updateMessage(
      message.copyWith(isFavorite: true),
    );
  }

  @override
  Future<void> remove(Message message) async {
    _repository.deleteMessage(message.id);
  }

  @override
  Future<void> removeAll(MessageList messages) async {
    _repository.deleteMessages(
      messages.map((message) => message.id).toIList(),
    );
  }

  @override
  Future<void> removeFromFavorites(Message message) async {
    await _repository.updateMessage(
      message.copyWith(isFavorite: true),
    );
  }

  @override
  Future<void> update(Message message) async {
    await _repository.updateMessage(message);
  }

  @override
  Future<void> search(String query, [TagList? tags]) async {
    _filteredChatStream.add(
      _applyFilter(
        _repository.messagesOf(chatId: chat.id),
        query,
        tags,
      ),
    );
  }

  ValueStream<MessageList> _applyFilter(
    ValueStream<MessageList> stream,
    String query, [
    TagList? tags,
  ]) {
    return stream.map(
      (chat) {
        return _filterMessages(chat, query, tags);
      },
    ).shareValueSeeded(
      _filterMessages(stream.value, query, tags),
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
        } else {
          return message.tags.containsAll(tags) &&
              message.text.containsIgnoreCase(query);
        }
      },
    ).toIList();
  }
}
