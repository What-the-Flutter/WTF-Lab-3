import 'package:bloc/bloc.dart';

import '../../../common/api/chat_repository_api.dart';
import 'chat_search_state.dart';

class ChatSearchCubit extends Cubit<ChatSearchState> {
  ChatSearchCubit({
    required ChatRepositoryApi repository,
    required this.chatId,
  })  : _repository = repository,
        super(const ChatSearchState.initial());

  final ChatRepositoryApi _repository;
  final int chatId;

  void search(String text) async {
    var chat = await _repository.findById(chatId);
    var messages = chat.messages.where(
        (message) => message.text.toLowerCase().contains(text.toLowerCase()));

    if (messages.isNotEmpty) {
      emit(
        ChatSearchState.withResults(
          messages: messages.toList(),
        ),
      );
    } else {
      emit(
        const ChatSearchState.empty(),
      );
    }
  }
}
