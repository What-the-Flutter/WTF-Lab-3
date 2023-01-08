import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/data/models/chat.dart';

part 'chat_overview_state.dart';
part 'chat_overview_cubit.freezed.dart';

class ChatOverviewCubit extends Cubit<ChatOverviewState> {
  ChatOverviewCubit({
    required this.repository,
  }) : super(const ChatOverviewState(chats: IListConst([]))) {
    repository.chats.listen(
      (event) {
        emit(
          ChatOverviewState(
            chats: event.lock.whereMoveToTheStart(
              (chat) => chat.isPinned,
            ),
          ),
        );
      },
    );
    repository.loadData();
  }

  final ChatRepositoryApi repository;
}
