import '../api/chat_provider_api.dart';
import '../api/chat_repository_api.dart';
import 'models/chat.dart';

class ChatRepository extends ChatRepositoryApi {
  ChatRepository({
    required ChatProviderApi provider,
  }) : _provider = provider {
    chats.listen(
      (event) {
        lastChats = event;
      },
    );
  }

  final ChatProviderApi _provider;

  late List<Chat> lastChats;

  @override
  Stream<List<Chat>> get chats => _provider.getChats();

  @override
  Future<void> add(Chat chat) async {
    await _provider.saveChat(chat);
  }

  @override
  Future<Chat> findById(int id) async {
    return lastChats.firstWhere(
      (e) => e.id == id,
    );
  }

  @override
  Future<void> pin(Chat chat) async {
    await _provider.saveChat(
      chat.copyWith(
        isPinned: true,
      ),
    );
  }

  @override
  Future<void> remove(Chat chat) async {
    await _provider.deleteChat(chat.id);
  }

  @override
  Future<void> togglePin(Chat chat) async {
    await _provider.saveChat(
      chat.copyWith(
        isPinned: !chat.isPinned,
      ),
    );
  }

  @override
  Future<void> unpin(Chat chat) async {
    await _provider.saveChat(
      chat.copyWith(
        isPinned: false,
      ),
    );
  }

  @override
  Future<void> update(Chat chat) async {
    await _provider.saveChat(chat);
  }
  
  @override
  Future<void> loadData() async {
    _provider.loadData();
  }
}
