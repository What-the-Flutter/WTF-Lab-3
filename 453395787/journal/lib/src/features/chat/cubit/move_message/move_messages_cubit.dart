import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/api/repository/chat_repository_api.dart';
import '../../../../common/models/ui/chat.dart';
import '../../../../common/utils/typedefs.dart';
import '../../api/chat_messages_repository_api.dart';

part 'move_messages_state.dart';

part 'move_messages_cubit.freezed.dart';

class MoveMessagesCubit extends Cubit<MoveMessagesState> {
  MoveMessagesCubit({
    required ChatRepositoryApi chatRepository,
    required ChatMessagesRepositoryApi messageRepository,
    required this.fromChatId,
    required this.messages,
  })  : _chatRepository = chatRepository,
        _messageRepository = messageRepository,
        super(
          MoveMessagesState.initial(
            chats: chatRepository.chats.value
                .where((chat) => chat.id != fromChatId)
                .toIList(),
            amountOfMessages: messages.length,
          ),
        );

  final ChatRepositoryApi _chatRepository;
  final ChatMessagesRepositoryApi _messageRepository;
  final String fromChatId;
  final MessageList messages;

  void select(String id) {
    state.map(
      initial: (initial) {
        emit(
          MoveMessagesState.hasSelectedState(
            chats: initial.chats,
            amountOfMessages: initial.amountOfMessages,
            selectedChatId: id,
          ),
        );
      },
      hasSelectedState: (hasSelectedState) {
        emit(
          hasSelectedState.copyWith(
            selectedChatId: id,
          ),
        );
      },
    );
  }

  void unselect(String id) {
    state.mapOrNull(
      hasSelectedState: (hasSelectedState) {
        emit(
          MoveMessagesState.initial(
            chats: hasSelectedState.chats,
            amountOfMessages: hasSelectedState.amountOfMessages,
          ),
        );
      },
    );
  }

  void toggleSelection(String id) {
    state.map(
      initial: (initial) {
        select(id);
      },
      hasSelectedState: (hasSelectedState) {
        if (hasSelectedState.selectedChatId == id) {
          unselect(id);
        } else {
          select(id);
        }
      },
    );
  }

  Future<void> move() async {
    state.mapOrNull(
      hasSelectedState: (hasSelectedState) async {
        await _messageRepository.removeAll(messages);
        for (var message in messages) {
          await _messageRepository.addToOtherChat(
            hasSelectedState.selectedChatId,
            message,
          );
        }
      },
    );
  }
}
