import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../api/chat_provider_api.dart';
import '../api/chat_repository_api.dart';
import '../models/chat.dart';

class ChatRepository extends ChatRepositoryApi {
  ChatRepository({
    required ChatProviderApi provider,
  }) : _provider = provider {
    _provider.getChats().then(_chats.add);
  }

  final ChatProviderApi _provider;
  final BehaviorSubject<IList<Chat>> _chats = BehaviorSubject();

  @override
  ValueStream<IList<Chat>> get chats => _chats.stream;

  @override
  Future<void> add(Chat chat) async {
    await _provider.addChat(chat);
    _chats.add(await _provider.getChats());
  }

  @override
  Future<Chat?> findById(int id) async {
    return _provider.getChat(id);
  }

  @override
  Future<void> pin(Chat chat) async {
    await _provider.updateChat(
      chat.copyWith(
        isPinned: true,
      ),
    );
    _chats.add(await _provider.getChats());
  }

  @override
  Future<void> remove(Chat chat) async {
    await _provider.deleteChat(chat.id);
    _chats.add(await _provider.getChats());
  }

  @override
  Future<void> togglePin(Chat chat) async {
    await _provider.updateChat(
      chat.copyWith(
        isPinned: !chat.isPinned,
      ),
    );
    _chats.add(await _provider.getChats());
  }

  @override
  Future<void> unpin(Chat chat) async {
    await _provider.updateChat(
      chat.copyWith(
        isPinned: false,
      ),
    );
    _chats.add(await _provider.getChats());
  }

  @override
  Future<void> update(Chat chat) async {
    await _provider.updateChat(chat);
    _chats.add(await _provider.getChats());
  }

  @override
  Future<void> load() async {
    _chats.add(await _provider.getChats());
  }
}
