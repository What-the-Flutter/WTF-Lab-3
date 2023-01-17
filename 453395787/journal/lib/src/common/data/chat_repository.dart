import 'package:rxdart/rxdart.dart';

import '../api/chat_provider_api.dart';
import '../api/chat_repository_api.dart';
import '../models/chat_view.dart';
import '../utils/typedefs.dart';

class ChatRepository extends ChatRepositoryApi {
  ChatRepository({
    required ChatProviderApi provider,
  }) : _provider = provider;

  final ChatProviderApi _provider;

  @override
  ValueStream<ChatViewList> get chats => _provider.chats;

  @override
  Future<void> add(ChatView chat) async {
    await _provider.addChat(chat);
  }

  @override
  Future<void> pin(ChatView chat) async {
    await _provider.updateChat(
      chat.copyWith(
        isPinned: true,
      ),
    );
  }

  @override
  Future<void> remove(ChatView chat) async {
    await _provider.deleteChat(chat.id);
  }

  @override
  Future<void> togglePin(ChatView chat) async {
    await _provider.updateChat(
      chat.copyWith(
        isPinned: !chat.isPinned,
      ),
    );
  }

  @override
  Future<void> unpin(ChatView chat) async {
    await _provider.updateChat(
      chat.copyWith(
        isPinned: false,
      ),
    );
  }

  @override
  Future<void> update(ChatView chat) async {
    await _provider.updateChat(chat);
  }
}
