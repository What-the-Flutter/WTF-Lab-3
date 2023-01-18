import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/models/chat_view.dart';
import '../../../common/utils/typedefs.dart';

part 'chat_overview_state.dart';

part 'chat_overview_cubit.freezed.dart';

class ChatOverviewCubit extends Cubit<ChatOverviewState> {
  ChatOverviewCubit({
    required ChatRepositoryApi repository,
  })  : _repository = repository,
        super(
          ChatOverviewState(
            chats: ChatViewList([]),
          ),
        ) {
    _chatsStreamSubscription = repository.chats.listen(
      (event) {
        emit(
          ChatOverviewState(
            chats: event.whereMoveToTheStart(
              (chat) => chat.isPinned,
            ),
          ),
        );
      },
    );
  }

  final ChatRepositoryApi _repository;
  late StreamSubscription<ChatViewList> _chatsStreamSubscription;

  @override
  Future<void> close() async {
    _chatsStreamSubscription.cancel();
    super.close();
  }
}
