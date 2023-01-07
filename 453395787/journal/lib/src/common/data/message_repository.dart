import '../api/chat_repository_api.dart';
import '../api/message_repository_api.dart';
import 'models/chat.dart';
import 'models/message.dart';

class MessageRepository extends MessageRepositoryApi {
  MessageRepository({
    required this.chatRepository,
    required this.chatIndex,
  });

  final ChatRepositoryApi chatRepository;
  final int chatIndex;

  @override
  Stream<Chat> get stream =>
      chatRepository.chats.map((event) => event[chatIndex]);

  @override
  Future<void> add(Message message) async {
    var chat = await chatRepository.findById(chatIndex);
    if (chat.messages.map((e) => e.id).contains(message.id)) {
      update(message);
    } else {
      await chatRepository.update(
        chat.copyWith(
          messages: chat.messages.add(message),
        ),
      );
    }
  }

  @override
  Future<void> addToFavorites(Message message) async {
    var chat = await chatRepository.findById(chatIndex);

    await chatRepository.update(
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
    var chat = await chatRepository.findById(chatIndex);
    await chatRepository.update(
      chat.copyWith(
        messages: chat.messages.remove(message),
      ),
    );
  }

  @override
  Future<void> removeFromFavorites(Message message) async {
    var chat = await chatRepository.findById(chatIndex);

    await chatRepository.update(
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
    var chat = await chatRepository.findById(chatIndex);

    await chatRepository.update(
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
    chatRepository.loadData();
  }
}
