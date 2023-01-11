import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/api/chat_repository_api.dart';
import '../../../../common/models/chat.dart';
import '../../../../common/models/message.dart';

part 'move_messages_state.dart';

part 'move_messages_cubit.freezed.dart';

class MoveMessagesCubit extends Cubit<MoveMessagesState> {
  MoveMessagesCubit({
    required ChatRepositoryApi repository,
    required this.fromChatId,
    required this.messages,
  })  : _repository = repository,
        super(
          MoveMessagesState.initial(
            chats: repository.chats.value
                .where((chat) => chat.id != fromChatId)
                .toIList(),
            amountOfMessages: messages.length,
          ),
        );

  final ChatRepositoryApi _repository;
  final int fromChatId;
  final IList<Message> messages;

  void select(int id) {
    state.map(
      initial: (initial) {
        emit(
          MoveMessagesState.withSelected(
            chats: initial.chats,
            amountOfMessages: initial.amountOfMessages,
            selectedChatId: id,
          ),
        );
      },
      withSelected: (withSelected) {
        emit(
          withSelected.copyWith(
            selectedChatId: id,
          ),
        );
      },
    );
  }

  void unselect(int id) {
    state.mapOrNull(
      withSelected: (withSelected) {
        emit(
          MoveMessagesState.initial(
            chats: withSelected.chats,
            amountOfMessages: withSelected.amountOfMessages,
          ),
        );
      },
    );
  }

  void toggleSelection(int id) {
    state.map(
      initial: (initial) {
        select(id);
      },
      withSelected: (withSelected) {
        if (withSelected.selectedChatId == id) {
          unselect(id);
        } else {
          select(id);
        }
      },
    );
  }

  void move() {
    state.mapOrNull(
      withSelected: (withSelected) {
        var oldChat = _repository.chats.value.firstWhere(
          (chat) => chat.id == fromChatId,
        );
        _repository.update(
          oldChat.copyWith(
            messages: oldChat.messages.removeAll(messages),
          ),
        );

        var newChat = _repository.chats.value.firstWhere(
          (chat) => chat.id == withSelected.selectedChatId,
        );
        _repository.update(
          newChat.copyWith(
            messages: newChat.messages
                .addAll(messages)
                .sort((a, b) => a.dateTime.compareTo(b.dateTime)),
          ),
        );
      },
    );
  }
}
