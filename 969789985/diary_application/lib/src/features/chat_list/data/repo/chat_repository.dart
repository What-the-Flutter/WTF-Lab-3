import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';


import '../../domain/chat_model.dart';
import '../interfaces/chat_provider_interface.dart';
import '../interfaces/chat_repository_interface.dart';

class ChatRepository extends ChatRepositoryInterface {
  ChatRepository({
    required ChatProviderInterface provider,
  }) : _provider = provider {
    _provider.all().then(_chats.add);
  }

  final ChatProviderInterface _provider;
  final BehaviorSubject<IList<ChatModel>> _chats = BehaviorSubject();

  @override
  ValueStream<IList<ChatModel>> get chats => _chats.stream;

  @override
  Future<void> add(ChatModel chat) async {
    await _provider.add(chat);
    _chats.add(await _provider.all());
  }

  @override
  Future<ChatModel?> chatById(int id) async => await _provider.chatById(id);

  @override
  Future<void> remove(ChatModel chat) async {
    await _provider.remove(chat.id);
    _chats.add(await _provider.all());
  }

  @override
  Future<void> update(ChatModel chat) async {
    await _provider.update(chat);
    _chats.add(await _provider.all());
  }

  @override
  Future<void> upload() async => _chats.add(await _provider.all());


}
