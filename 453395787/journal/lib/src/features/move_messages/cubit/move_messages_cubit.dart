import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/data/models/chat.dart';
import '../../../common/data/models/message.dart';

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
        ) {
          print(state);
        }

  final ChatRepositoryApi _repository;
  final int fromChatId;
  final IList<Message> messages;

  void select(int id) {
    state.map(
      initial: (initial) {
        emit(
          MoveMessagesState.selected(
            chats: initial.chats,
            amountOfMessages: initial.amountOfMessages,
            selectedChatId: id,
          ),
        );
      },
      selected: (selected) {
        emit(
          selected.copyWith(selectedChatId: id),
        );
      },
    );
  }

  void unselect(int id) {
    state.map(
      initial: (initial) {},
      selected: (selected) {
        emit(
          MoveMessagesState.initial(
            chats: selected.chats,
            amountOfMessages: selected.amountOfMessages,
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
      selected: (selected) {
        if (selected.selectedChatId == id) {
          unselect(id);
        } else {
          select(id);
        }
      },
    );
  }

  void apply() {
    state.map(
      initial: (initial) {},
      selected: (selected) {
        var oldChat = _repository.chats.value.firstWhere(
          (chat) => chat.id == fromChatId,
        );
        _repository.update(
          oldChat.copyWith(
            messages: oldChat.messages.removeAll(messages),
          ),
        );

        var newChat = _repository.chats.value.firstWhere(
          (chat) => chat.id == selected.selectedChatId,
        );
        _repository.update(
          newChat.copyWith(
            messages: newChat.messages.addAll(messages).sort((a, b) => a.dateTime.compareTo(b.dateTime)),
          ),
        );
      },
    );
  }
}
