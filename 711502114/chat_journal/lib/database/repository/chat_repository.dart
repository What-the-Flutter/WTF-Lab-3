import '../../models/chat.dart';
import '../converter/converter_db.dart';
import '../provider/data_provider.dart';
import 'chat_repository_api.dart';

class ChatRepository extends ChatRepositoryApi {
  final provider = DataProvider();

  @override
  Future<void> addChat(Chat chat) async {
    final dbChat = ConverterDB.chat2Entity(chat);
    await provider.addChat(dbChat);
  }

  @override
  Future<void> changeChat(Chat chat) async {
    await provider.updateChat(ConverterDB.chat2Entity(chat));
  }

  @override
  Future<void> deleteChat(Chat chat) async {
    await provider.deleteChat(ConverterDB.chat2Entity(chat));
  }

  @override
  Future<List<Chat>> getChats() async {
    final chatsDB = await provider.chats;
    chatsDB.sort((b, a) => a.isPin.compareTo(b.isPin));
    return List<Chat>.generate(chatsDB.length, (index) {
      return ConverterDB.entity2Chat(chatsDB[index]);
    });
  }
}
