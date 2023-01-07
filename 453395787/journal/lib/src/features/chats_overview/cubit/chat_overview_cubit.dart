import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/data/models/chat.dart';

part 'chat_overview_state.dart';

class ChatOverviewCubit extends Cubit<ChatOverviewState> {
  ChatOverviewCubit({
    required this.repository,
  }) : super(const ChatOverviewState(chats: [])) {
    repository.chats.listen(
      (event) {
        emit(
          ChatOverviewState(chats: event),
        );
      },
    );
    repository.loadData();
  }

  final ChatRepositoryApi repository;
}
