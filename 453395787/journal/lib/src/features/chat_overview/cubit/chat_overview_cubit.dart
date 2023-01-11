import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/models/chat.dart';

part 'chat_overview_state.dart';

part 'chat_overview_cubit.freezed.dart';

class ChatOverviewCubit extends Cubit<ChatOverviewState> {
  ChatOverviewCubit({
    required this.repository,
  }) : super(
          const ChatOverviewState(
            chats: IListConst([]),
          ),
        ) {
    _subscription = repository.chats.listen(
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
    repository.load();
  }

  final ChatRepositoryApi repository;
  late StreamSubscription<IList<Chat>> _subscription;

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }
}
