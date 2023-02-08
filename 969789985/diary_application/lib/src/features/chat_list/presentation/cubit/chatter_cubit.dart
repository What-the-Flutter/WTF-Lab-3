import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/interfaces/chat_repository_interface.dart';
import '../../domain/chat_model.dart';

part 'chatter_state.dart';

part 'chatter_cubit.freezed.dart';

class ChatterCubit extends Cubit<ChatterState> {
  ChatterCubit({
    required ChatRepositoryInterface repository,
  })
      : _repository = repository,
        super(
        const ChatterState(
          chats: IListConst([]),
        ),
      ) {
    _subscription = _repository.chats.listen(
          (event) {
        emit(
          ChatterState(
            chats: event.whereMoveToTheStart((chat) => chat.isPinned),
          ),
        );
      },
    );
  }

  final ChatRepositoryInterface _repository;
  late StreamSubscription<IList<ChatModel>> _subscription;

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }
}
