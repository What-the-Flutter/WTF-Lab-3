import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../chat_list/domain/chat_model.dart';
import '../../../data/interfaces/message_repository_interface.dart';
import '../../../domain/message_model.dart';

part 'message_search_state.dart';

part 'message_search_cubit.freezed.dart';

class MessageSearchCubit extends Cubit<MessageSearchState> {
  MessageSearchCubit({
    required MessageRepositoryInterface repository,
  })  : _repository = repository,
        super(const MessageSearchState.defaultMode(
          messages: IListConst([]),
          isSearchMode: false,
        )) {
    _subscription = _repository.rxChatStreams.listen(
      (event) {
        _interiorSubscription?.cancel();
        _interiorSubscription = event.listen(
          (chat) {
            emit(
              MessageSearchState.defaultMode(
                messages: chat.messages,
                isSearchMode: false,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryInterface _repository;

  late IList<MessageModel> messages;

  late StreamSubscription<ValueStream<ChatModel>> _subscription;
  StreamSubscription<ChatModel>? _interiorSubscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    _interiorSubscription?.cancel();

    return super.close();
  }

  void updateSearchMode() {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        if (!defaultMode.isSearchMode) {
          messages = defaultMode.messages;
          emit(
            MessageSearchState.searchActive(
              messages: messages,
              isSearchMode: !defaultMode.isSearchMode,
              query: '',
            ),
          );
        }
      },
      searchActive: (searchActive) {
        if (searchActive.isSearchMode) {
          emit(
            MessageSearchState.defaultMode(
              messages: messages,
              isSearchMode: !searchActive.isSearchMode,
            ),
          );
        }
      },
    );
  }

  void onQueryChanged(String query) {
    state.mapOrNull(
      searchActive: (searchActive) {
        if (query.isEmpty) {
          emit(
            searchActive.copyWith(
              messages: messages,
              query: '',
            ),
          );
        } else {
          emit(
            searchActive.copyWith(
              messages: messages
                  .where(
                    (mes) => mes.messageText
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              )
                  .toIList(),
              query: query,
            )
          );
        }
      },
    );
  }
}
