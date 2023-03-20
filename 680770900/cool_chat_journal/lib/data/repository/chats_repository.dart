import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../provider/firebase_provider.dart';

class ChatsRepository {
  final FirebaseProvider _firebaseProvider;

  ChatsRepository({required User? user}) 
    : _firebaseProvider = FirebaseProvider(user: user);

  Future<List<Chat>> readChats() async {
    final jsonChats = await _firebaseProvider.read<Chat>(
      tableName: FirebaseProvider.chatsRoot,
    );

    return jsonChats.map(Chat.fromJson).toList();
  }
  
  Future<void> addChat(Chat chat) async =>
    await _firebaseProvider.add(
      json: chat.toJson(), 
      tableName: FirebaseProvider.chatsRoot,
    );

  Future<void> deleteChat(String chatId) async =>
    await _firebaseProvider.delete(
      id: chatId,
      tableName: FirebaseProvider.chatsRoot,
    );

  Future<void> updateChat(Chat chat) async {
    await _firebaseProvider.delete(
      id: chat.id,
      tableName: FirebaseProvider.chatsRoot,  
    );
    await _firebaseProvider.add(
      json: chat.toJson(),
      tableName: FirebaseProvider.chatsRoot,
    );
  }
}
