import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/models/local/chat/chat_model.dart';
import '../../../core/domain/repository/chat/api_chat_repository.dart';

part 'chatter_cubit.freezed.dart';
part 'chatter_state.dart';

class ChatterCubit extends Cubit<ChatterState> {
  final ApiChatRepository _repository;
  late StreamSubscription<IList<ChatModel>> _subscription;

  ChatterCubit({
    required ApiChatRepository repository,
  })  : _repository = repository,
        super(
          const ChatterState(
            chats: IListConst([]),
          ),
        ) {
    _subscription = _repository.chats.listen(
      (chat) {
        emit(
          ChatterState(
            chats: chat.sort((a, b) => b.isPinned.compareTo(a.isPinned)),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    _subscription.cancel();

    super.close();
  }
}
