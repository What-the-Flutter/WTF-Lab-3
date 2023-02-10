import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/chat_model.dart';
import '../interfaces/chat_provider_interface.dart';
import '../interfaces/chat_repository_interface.dart';

class ChatRepository extends ChatRepositoryInterface {
  ChatRepository({
    required ChatProviderInterface provider,
  }) : _provider = provider;

  final ChatProviderInterface _provider;

  @override
  ValueStream<IList<ChatModel>> get chats => _provider.allChats;

  @override
  Future<void> add(ChatModel chat) async => await _provider.addChat(chat);

  @override
  Future<void> remove(ChatModel chat) async =>
      await _provider.removeChat(chat.id);

  @override
  Future<void> update(ChatModel chat) async => await _provider.updateChat(chat);
}
