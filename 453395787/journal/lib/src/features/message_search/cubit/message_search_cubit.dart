import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/message_repository_api.dart';
import '../../../common/data/models/chat.dart';
import '../../../common/data/models/message.dart';
import '../../../common/data/models/tag.dart';

part 'message_search_state.dart';
part 'message_search_cubit.freezed.dart';

class MessageSearchCubit extends Cubit<MessageSearchState> {
  MessageSearchCubit({
    required MessageRepositoryApi repository,
  })  : _repository = repository,
        super(const MessageSearchState.initial()) {
    _repository.filteredChatStreams.listen(
      (event) {
        _subscriber?.cancel();
        _subscriber = event.listen(
          (chat) {
            emit(
              MessageSearchState.results(
                messages: chat.messages,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryApi _repository;
  StreamSubscription<Chat>? _subscriber;

  void search(String query, [IList<Tag>? tags]) async {
    emit(const MessageSearchState.loading());
    await _repository.search(query, tags);
  }
}
