import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../../chat_list/data/interfaces/chat_repository_interface.dart';
import '../../../chat_list/domain/chat_model.dart';
import '../../domain/message_model.dart';
import '../interfaces/message_repository_interface.dart';

class MessageRepository extends MessageRepositoryInterface {
  MessageRepository({
    required ChatRepositoryInterface repository,
    required this.chatId,
  }) : _repository = repository {
    _rxChatStream.add(_getSeededChatStream());

    _repository.chats.listen(
      (event) {
        _rxChatStream.add(
          _getSeededChatStream(),
        );
      },
    );
  }

  final ChatRepositoryInterface _repository;
  final int chatId;

  final BehaviorSubject<ValueStream<ChatModel>> _rxChatStream =
      BehaviorSubject();

  @override
  ValueStream<ValueStream<ChatModel>> get rxChatStreams =>
      _rxChatStream.stream;

  @override
  Future<void> upload() async => await _repository.upload();

  @override
  Future<void> add(MessageModel message) async {
    final chat = await _repository.chatById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.add(message),
      ),
    );
  }

  @override
  Future<void> update(MessageModel message) async {
    final chat = await _repository.chatById(chatId);
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
  Future<void> remove(MessageModel message) async {
    final chat = await _repository.chatById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.remove(message),
      ),
    );
  }

  @override
  Future<void> removeSelected(
    IList<MessageModel> messages,
    IMap<int, bool> selected,
  ) async {
    final chat = await _repository.chatById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.removeWhere(
          (mes) => selected.containsKey(mes.id),
        ),
      ),
    );
  }

  @override
  Future<void> addToFavorites(MessageModel message) async {
    final chat = await _repository.chatById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.updateById(
          [
            message.copyWith(isFavorite: true),
          ],
          (item) => item.id == message.id,
        ),
      ),
    );
  }

  @override
  Future<void> removeFromFavorites(MessageModel message) async {
    final chat = await _repository.chatById(chatId);
    if (chat == null) return;

    await _repository.update(
      chat.copyWith(
        messages: chat.messages.updateById(
          [
            message.copyWith(isFavorite: false),
          ],
          (item) => item.id == message.id,
        ),
      ),
    );
  }

  ValueStream<ChatModel> _getSeededChatStream() {
    return ValueConnectableStream.seeded(
      _repository.chats.map(
        (event) => _findByIndex(event, chatId),
      ),
      _findByIndex(_repository.chats.value, chatId),
    );
  }

  ChatModel _findByIndex(IList<ChatModel> chats, int id) {
    return chats.firstWhere((chat) => chat.id == id);
  }
}
