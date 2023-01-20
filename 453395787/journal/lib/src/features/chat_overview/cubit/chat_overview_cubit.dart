import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/repository/chat_repository_api.dart';
import '../../../common/models/db/db_chat.dart';
import '../../../common/models/ui/chat.dart';
import '../../../common/utils/typedefs.dart';

part 'chat_overview_state.dart';

part 'chat_overview_cubit.freezed.dart';

class ChatOverviewCubit extends Cubit<ChatOverviewState> {
  ChatOverviewCubit({
    required ChatRepositoryApi chatRepository,
  })  : _repository = chatRepository,
        super(
          ChatOverviewState(
            chats: IList<Chat>([]),
          ),
        ) {
    _chatsStreamSubscription = chatRepository.chats.listen(
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
  late StreamSubscription<IList<Chat>> _chatsStreamSubscription;

  @override
  Future<void> close() async {
    _chatsStreamSubscription.cancel();
    super.close();
  }
}
