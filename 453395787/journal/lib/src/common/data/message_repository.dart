import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../api/chat_repository_api.dart';
import '../api/message_repository_api.dart';
import 'models/chat.dart';
import 'models/message.dart';
import 'models/tag.dart';

class MessageRepository extends MessageRepositoryApi {
  MessageRepository({
    required ChatRepositoryApi repository,
    required this.chatIndex,
  }) : _repository = repository {
    _fileterdChatStream.add(_getThisChatStream());
    _repository.chats.listen(
      (event) {
        _fileterdChatStream.add(
          _getThisChatStream(),
        );
      },
    );
  }

  final ChatRepositoryApi _repository;
  final int chatIndex;

  final BehaviorSubject<ValueStream<Chat>> _fileterdChatStream =
      BehaviorSubject();

  @override
  ValueStream<ValueStream<Chat>> get filteredChatStreams =>
      _fileterdChatStream.stream;

  @override
  Future<void> add(Message message) async {
    var chat = await _repository.findById(chatIndex);
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
    var chat = await _repository.findById(chatIndex);

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
    var chat = await _repository.findById(chatIndex);
    await _repository.update(
      chat.copyWith(
        messages: chat.messages.remove(message),
      ),
    );
  }

  @override
  Future<void> removeFromFavorites(Message message) async {
    var chat = await _repository.findById(chatIndex);

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
    var chat = await _repository.findById(chatIndex);

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
    _repository.loadData();
  }

  @override
  Future<void> search(String query, [IList<Tag>? tags]) async {
    _fileterdChatStream.add(
      _applySearch(
        _getThisChatStream(),
        query,
        tags,
      ),
    );
  }

  ValueStream<Chat> _applySearch(
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
            return _containsIgnoreCase(
              message.text,
              query,
            );
          } else {
            for (var tag in tags) {
              if (message.tags.contains(tag) &&
                  _containsIgnoreCase(message.text, query)) {
                return true;
              }
            }
            return false;
          }
        },
      ).toIList(),
    );
  }

  bool _containsIgnoreCase(String text, String part) {
    return text.toLowerCase().contains(part.toLowerCase());
  }

  ValueStream<Chat> _getThisChatStream() {
    return ValueConnectableStream.seeded(
      _repository.chats.map(
        (event) => _findByIndex(event, chatIndex),
      ),
      _findByIndex(_repository.chats.value, chatIndex),
    );
  }

  Chat _findByIndex(List<Chat> chats, int id) {
    return chats.firstWhere((chat) => chat.id == id);
  }
}
