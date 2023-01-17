import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/api/chat_repository_api.dart';
import '../../../../common/api/message_provider_api.dart';
import '../../../../common/models/chat_view.dart';
import '../../../../common/utils/typedefs.dart';

part 'move_messages_state.dart';

part 'move_messages_cubit.freezed.dart';

class MoveMessagesCubit extends Cubit<MoveMessagesState> {
  MoveMessagesCubit({
    required ChatRepositoryApi chatRepository,
    required MessageProviderApi messageProviderApi,
    required this.fromChatId,
    required this.messages,
  })  : _chatRepository = chatRepository,
        _messageProviderApi = messageProviderApi,
        super(
          MoveMessagesState.initial(
            chats: chatRepository.chats.value
                .where((chat) => chat.id != fromChatId)
                .toIList(),
            amountOfMessages: messages.length,
          ),
        );

  final ChatRepositoryApi _chatRepository;
  final MessageProviderApi _messageProviderApi;
  final int fromChatId;
  final MessageList messages;

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

  Future<void> move() async {
    state.mapOrNull(
      withSelected: (withSelected) async {
        await _messageProviderApi.deleteMessages(
          messages.map((message) => message.id).toIList(),
        );
        for (var message in messages) {
          await _messageProviderApi.addMessage(
            withSelected.selectedChatId,
            message,
          );
        }
      },
    );
  }
}
