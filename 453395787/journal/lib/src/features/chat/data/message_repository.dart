import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/api/message_provider_api.dart';
import '../../../common/extensions/iterable_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../common/models/chat_view.dart';
import '../../../common/models/message.dart';
import '../../../common/models/tag.dart';
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
        print('asdfasdfasdfoqwieurlaskfj');
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
  ValueStream<IList<Tag>> get tags => _repository.tags;

  final BehaviorSubject<ValueStream<IList<Message>>> _filteredChatStream =
      BehaviorSubject();

  late final StreamSubscription<IList<Message>> _subscription;

  void close() {
    _subscription.cancel();
    _filteredChatStream.close();
  }

  @override
  ValueStream<ValueStream<IList<Message>>> get filteredChatStreams =>
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
  Future<void> removeAll(IList<Message> messages) async {
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
  Future<void> search(String query, [IList<Tag>? tags]) async {
    _filteredChatStream.add(
      _applyFilter(
        _repository.messagesOf(chatId: chat.id),
        query,
        tags,
      ),
    );
  }

  ValueStream<IList<Message>> _applyFilter(
    ValueStream<IList<Message>> stream,
    String query, [
    IList<Tag>? tags,
  ]) {
    return stream.map(
      (chat) {
        return _filterMessages(chat, query, tags);
      },
    ).shareValueSeeded(
      _filterMessages(stream.value, query, tags),
    );
  }

  IList<Message> _filterMessages(
    IList<Message> messages,
    String query, [
    IList<Tag>? tags,
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
