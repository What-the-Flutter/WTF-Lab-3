import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/models/message.dart';
import '../../../../common/models/tag.dart';
import '../../../../common/utils/typedefs.dart';
import '../../api/message_repository_api.dart';

part 'message_search_cubit.freezed.dart';

part 'message_search_state.dart';

class MessageSearchCubit extends Cubit<MessageSearchState> {
  MessageSearchCubit({
    required MessageRepositoryApi repository,
  })  : _repository = repository,
        super(const MessageSearchState.initial()) {
    _messageStreamUpdatesSub = _repository.filteredChatStreams.listen(
      (event) {
        _messageStreamSub?.cancel();
        if (state.query != null || state.queryTags != null) {
          emit(
            MessageSearchState.success(
              query: state.query ?? '',
              queryTags: state.queryTags,
              messages: event.value,
            ),
          );
        }
        _messageStreamSub = event.listen(
          (messages) {
            emit(
              MessageSearchState.success(
                query: state.query!,
                queryTags: state.queryTags,
                messages: messages,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryApi _repository;
  late StreamSubscription<ValueStream<MessageList>> _messageStreamUpdatesSub;
  StreamSubscription<MessageList>? _messageStreamSub;

  @override
  Future<void> close() async {
    _messageStreamUpdatesSub.cancel();
    _messageStreamSub?.cancel();
    super.close();
  }

  Future<void> onSearchQueryChanged(String query) async {
    emit(
      MessageSearchState.loading(
        query: query,
        queryTags: state.queryTags,
      ),
    );
    await _repository.search(query, state.queryTags);
  }

  Future<void> onSearchTagsChanged(TagList? tags) async {
    emit(
      MessageSearchState.loading(
        query: state.query!,
        queryTags: tags,
      ),
    );
    await _repository.search(state.query ?? '', tags);
  }

  Future<void> resetSearch() async {
    emit(
      const MessageSearchState.initial(),
    );
  }
}
