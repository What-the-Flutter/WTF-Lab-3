import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/models/ui/message.dart';
import '../../../../common/models/ui/tag.dart';
import '../../../../common/utils/typedefs.dart';
import '../../api/chat_messages_repository_api.dart';

part 'message_search_cubit.freezed.dart';

part 'message_search_state.dart';

class MessageSearchCubit extends Cubit<MessageSearchState> {
  MessageSearchCubit({
    required ChatMessagesRepositoryApi messageRepository,
  })  : _repository = messageRepository,
        super(const MessageSearchState.initial()) {
    _messageStreamSub = _repository.messages.listen(
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
  }

  final ChatMessagesRepositoryApi _repository;
  StreamSubscription<MessageList>? _messageStreamSub;

  @override
  Future<void> close() async {
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
