import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../chat/domain/message_model.dart';
import '../../domain/chat_model.dart';

abstract class ChatProviderInterface {
  Future<IList<ChatModel>> all();

  Future<ChatModel?> chatById(int id);

  Future<void> add(ChatModel chat);

  Future<void> update(ChatModel chat);

  Future<void> remove(int id);
}
