import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/models/chat.dart';
import '../../../../common/models/message.dart';
import '../../../../common/models/tag.dart';
import '../../api/message_repository_api.dart';

part 'message_search_cubit.freezed.dart';
part 'message_search_state.dart';

class MessageSearchCubit extends Cubit<MessageSearchState> {
  MessageSearchCubit({
    required MessageRepositoryApi repository,
  })  : _repository = repository,
        super(const MessageSearchState.initial()) {
    _subscription = _repository.filteredChatStreams.listen(
      (event) {
        _internalSubscription?.cancel();
        _internalSubscription = event.listen(
          (chat) {
            emit(
              MessageSearchState.results(
                query: state.query!,
                queryTags: state.queryTags,
                messages: chat.messages,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryApi _repository;
  late StreamSubscription<ValueStream<Chat>> _subscription;
  StreamSubscription<Chat>? _internalSubscription;
  
  @override
  Future<void> close() async {
    _subscription.cancel(); 
    _internalSubscription?.cancel();
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

  Future<void> onSearchTagsChanged(IList<Tag>? tags) async {
    emit(
      MessageSearchState.loading(
        query: state.query!,
        queryTags: tags,
      ),
    );
    await _repository.search(state.query ?? '', tags);
  }

  Future<void> resetSearch() async {
    emit(const MessageSearchState.initial());
  }
}
