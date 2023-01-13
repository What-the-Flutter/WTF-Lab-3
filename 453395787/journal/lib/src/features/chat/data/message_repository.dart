import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/extensions/iterable_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../common/models/chat.dart';
import '../../../common/models/message.dart';
import '../../../common/models/tag.dart';
import '../api/message_repository_api.dart';

class MessageRepository extends MessageRepositoryApi {
  MessageRepository({
    required ChatRepositoryApi repository,
    required this.chatId,
  }) : _repository = repository {
    _filteredChatStream.add(_getDefaultChatStream());

    _repository.chats.listen(
      (event) {
        _filteredChatStream.add(
          _getDefaultChatStream(),
        );
      },
    );
  }

  final ChatRepositoryApi _repository;
  final int chatId;

  final BehaviorSubject<ValueStream<Chat>> _filteredChatStream =
      BehaviorSubject();

  @override
  ValueStream<ValueStream<Chat>> get filteredChatStreams =>
      _filteredChatStream.stream;

  @override
  Future<void> add(Message message) async {
    final chat = await _repository.findById(chatId);
    if (chat == null) return;

    if (chat.messages.map((e) => e.id).contains(message.id)) {
      update(message);
    } else {
      await _repository.update(
        chat.copyWith(
          messages: chat.messages.add(message),
        ),
      );
    }
  }

  @override
  Future<void> addToFavorites(Message message) async {
    final chat = await _repository.findById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.updateById(
          [
            message.copyWith(
              isFavorite: true,
            ),
          ],
          (item) => item.id == message.id,
        ),
      ),
    );
  }

  @override
  Future<void> remove(Message message) async {
    final chat = await _repository.findById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.remove(message),
      ),
    );
  }

  @override
  Future<void> removeFromFavorites(Message message) async {
    final chat = await _repository.findById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.updateById(
          [
            message.copyWith(
              isFavorite: false,
            ),
          ],
          (item) => item.id == message.id,
        ),
      ),
    );
  }

  @override
  Future<void> update(Message message) async {
    final chat = await _repository.findById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.updateById(
          [message],
          (item) => item.id == message.id,
        ),
      ),
    );
  }

  @override
  Future<void> loadData() async {
    _repository.load();
  }

  @override
  Future<void> search(String query, [IList<Tag>? tags]) async {
    _filteredChatStream.add(
      _applyFilter(
        _getDefaultChatStream(),
        query,
        tags,
      ),
    );
  }

  ValueStream<Chat> _applyFilter(
    ValueStream<Chat> stream,
    String query, [
    IList<Tag>? tags,
  ]) {
    return ValueConnectableStream.seeded(
      stream.map(
        (chat) {
          return _filterMessages(chat, query, tags);
        },
      ),
      _filterMessages(stream.value, query, tags),
    );
  }

  Chat _filterMessages(
    Chat chat,
    String query, [
    IList<Tag>? tags,
  ]) {
    return chat.copyWith(
      messages: chat.messages.where(
        (message) {
          if (tags == null) {
            return message.text.containsIgnoreCase(query);
          } else {
            return message.tags.containsAll(tags) &&
                message.text.containsIgnoreCase(query);
          }
        },
      ).toIList(),
    );
  }

  ValueStream<Chat> _getDefaultChatStream() {
    return ValueConnectableStream.seeded(
      _repository.chats.map(
        (event) => _findByIndex(event, chatId),
      ),
      _findByIndex(_repository.chats.value, chatId),
    );
  }

  Chat _findByIndex(IList<Chat> chats, int id) {
    print(chats);
    print(id);
    return chats.firstWhere((chat) => chat.id == id);
  }
}
