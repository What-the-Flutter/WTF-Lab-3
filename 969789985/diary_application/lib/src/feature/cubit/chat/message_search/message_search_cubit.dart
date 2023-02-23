import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/api/message/api_message_repository.dart';
import '../../../../core/domain/models/local/message/message_model.dart';

part 'message_search_state.dart';

part 'message_search_cubit.freezed.dart';

class MessageSearchCubit extends Cubit<MessageSearchState> {
  MessageSearchCubit({
    required ApiMessageRepository repository,
  })  : _repository = repository,
        super(
          const MessageSearchState.defaultMode(
            messages: IListConst([]),
          ),
        ) {
    _subscription = _repository.rxChatStreams.listen(
      (messages) {
        this.messages = messages;
        emit(
          MessageSearchState.defaultMode(
            messages: messages,
          ),
        );
      },
    );
  }

  late IList<MessageModel> messages;

  final ApiMessageRepository _repository;
  late final StreamSubscription<IList<MessageModel>> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }

  void updateSearchMode() {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        emit(
          MessageSearchState.searchActive(
            messages: messages,
            query: '',
          ),
        );
      },
      searchActive: (searchActive) {
        emit(
          MessageSearchState.defaultMode(
            messages: messages,
          ),
        );
      }
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
            ),
          );
        }
      },
    );
  }
}
