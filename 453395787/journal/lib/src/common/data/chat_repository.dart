import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

import '../api/chat_provider_api.dart';
import '../api/chat_repository_api.dart';
import '../models/chat.dart';

class ChatRepository extends ChatRepositoryApi {
  ChatRepository({
    required ChatProviderApi provider,
  }) : _provider = provider {
    _provider.getAll().then(_chats.add);
  }

  final ChatProviderApi _provider;
  final BehaviorSubject<IList<Chat>> _chats = BehaviorSubject();

  @override
  ValueStream<IList<Chat>> get chats => _chats.stream;

  @override
  Future<void> add(Chat chat) async {
    await _provider.add(chat);
    _chats.add(await _provider.getAll());
  }

  @override
  Future<Chat?> findById(int id) async {
    return _provider.get(id);
  }

  @override
  Future<void> pin(Chat chat) async {
    await _provider.update(
      chat.copyWith(
        isPinned: true,
      ),
    );
    _chats.add(await _provider.getAll());
  }

  @override
  Future<void> remove(Chat chat) async {
    await _provider.delete(chat.id);
    _chats.add(await _provider.getAll());
  }

  @override
  Future<void> togglePin(Chat chat) async {
    await _provider.update(
      chat.copyWith(
        isPinned: !chat.isPinned,
      ),
    );
    _chats.add(await _provider.getAll());
  }

  @override
  Future<void> unpin(Chat chat) async {
    await _provider.update(
      chat.copyWith(
        isPinned: false,
      ),
    );
    _chats.add(await _provider.getAll());
  }

  @override
  Future<void> update(Chat chat) async {
    await _provider.update(chat);
    _chats.add(await _provider.getAll());
  }

  @override
  Future<void> load() async {
    _chats.add(await _provider.getAll());
  }
}
