import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/api/repository/chat_repository_api.dart';
import '../../../../common/models/ui/chat.dart';
import '../../../../common/models/ui/message.dart';
import '../../../../common/utils/typedefs.dart';
import '../../api/message_repository_api.dart';

part 'move_messages_state.dart';

part 'move_messages_cubit.freezed.dart';

class MoveMessagesCubit extends Cubit<MoveMessagesState> {
  MoveMessagesCubit({
    required ChatRepositoryApi chatRepositoryApi,
    required MessageRepositoryApi messageRepositoryApi,
    required this.fromChatId,
    required this.messages,
  })  : _chatRepositoryApi = chatRepositoryApi,
        _messageRepositoryApi = messageRepositoryApi,
        super(
          MoveMessagesState.initial(
            chats: chatRepositoryApi.chats.value
                .where((chat) => chat.id != fromChatId)
                .toIList(),
            amountOfMessages: messages.length,
          ),
        );

  final ChatRepositoryApi _chatRepositoryApi;
  final MessageRepositoryApi _messageRepositoryApi;
  final Id fromChatId;
  final IList<Message> messages;

  void select(Id id) {
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

  void unselect(Id id) {
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

  void toggleSelection(Id id) {
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
        await _messageRepositoryApi.removeAll(messages);
        for (var message in messages) {
          await _messageRepositoryApi.customAdd(
            hasSelectedState.selectedChatId,
            message,
          );
        }
      },
    );
  }
}
