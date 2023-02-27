import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/models/local/chat/chat_model.dart';
import '../../../core/domain/models/local/message/message_model.dart';
import '../../../core/domain/repository/chat/api_chat_repository.dart';
import '../../../core/domain/repository/message/api_message_repository.dart';

part 'timeline_state.dart';

part 'timeline_cubit.freezed.dart';

class TimelineCubit extends Cubit<TimelineState> {
  final ApiMessageRepository _repository;
  final ApiChatRepository _chatRepository;
  late final StreamSubscription<IList<MessageModel>> _subscription;
  late final StreamSubscription<IList<ChatModel>> _chatSubscription;

  TimelineCubit({
    required ApiMessageRepository repository,
    required ApiChatRepository chatRepository,
  })  : _repository = repository,
        _chatRepository = chatRepository,
        super(
          TimelineState.defaultMode(
            messages: IList<MessageModel>(),
            chats: IList<ChatModel>(),
            hashtag: '',
          ),
        ) {
    _subscription = _repository.messagesStreamForTimeline.listen(
      (messages) {
        emit(
          state.copyWith(
            messages: messages,
          ),
        );
      },
    );
    _chatSubscription = _chatRepository.chats.listen(
      (chats) {
        emit(
          state.copyWith(
            chats: chats,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }

  set hashtag(String hashtag) {
    emit(
      state.copyWith(
        hashtag: hashtag,
      ),
    );
  }
}
