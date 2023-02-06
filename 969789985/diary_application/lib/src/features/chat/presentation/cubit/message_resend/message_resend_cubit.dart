import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../chat_list/data/interfaces/chat_repository_interface.dart';
import '../../../../chat_list/domain/chat_model.dart';
import '../../../domain/message_model.dart';

part 'message_resend_state.dart';

part 'message_resend_cubit.freezed.dart';

class MessageResendCubit extends Cubit<MessageResendState> {
  MessageResendCubit({
    required ChatRepositoryInterface repository,
  })  : _repository = repository,
        super(
          MessageResendState(
            chats: repository.chats.value,
            selectedChats: IMap(),
          ),
        );

  final ChatRepositoryInterface _repository;

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

  void resendMessages(int currentChatId, IList<MessageModel> messages) {
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
