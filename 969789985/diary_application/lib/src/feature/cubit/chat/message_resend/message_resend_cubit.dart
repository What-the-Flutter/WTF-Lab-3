import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/domain/repository/chat/api_chat_repository.dart';
import '../../../../core/util/typedefs.dart';

part 'message_resend_cubit.freezed.dart';
part 'message_resend_state.dart';

class MessageResendCubit extends Cubit<MessageResendState> {
  final ApiChatRepository _repository;

  MessageResendCubit({
    required ApiChatRepository repository,
  })  : _repository = repository,
        super(
          MessageResendState(
            chats: repository.chats.value,
            selectedChats: IMap(),
          ),
        );

  IList<ChatModel> get _chats => _repository.chats.value;

  void updateChatSelection(int index) {
    emit(
      state.copyWith(
        chats: state.chats,
        selectedChats: state.selectedChats.containsKey(index)
            ? state.selectedChats
                .update(index, (value) => !state.selectedChats[index]!)
            : state.selectedChats.add(index, true),
      ),
    );
  }

  void resendMessages(FId currentChatId, IList<MessageModel> messages) {
    var currentChat = _chats.firstWhere(
      (chat) => chat.id == currentChatId,
    );

    _repository.update(
      currentChat.copyWith(
        messages: currentChat.messages.removeAll(messages),
      ),
    );

    for (final key in state.selectedChats.keys) {
      if (state.selectedChats[key]!) {
        final newChat = _chats.firstWhere(
          (chat) => chat.id == key,
        );
        _repository.update(
          newChat.copyWith(
            messages: newChat.messages.addAll(messages).sort(
                  (a, b) => a.sendDate.compareTo(b.sendDate),
                ),
          ),
        );
      }
    }
  }
}
