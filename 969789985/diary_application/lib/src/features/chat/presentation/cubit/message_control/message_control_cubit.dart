import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../chat_list/domain/chat_model.dart';
import '../../../data/interfaces/message_repository_interface.dart';
import '../../../domain/message_model.dart';

part 'message_control_state.dart';

part 'message_control_cubit.freezed.dart';

class MessageControlCubit extends Cubit<MessageControlState> {
  MessageControlCubit({
    required MessageRepositoryInterface repository,
  })  : _repository = repository,
        super(
          MessageControlState.defaultMode(
            messages: IList([]),
            selected: IMap(),
            message: MessageModel(),
            isSelectMode: false,
            isEditMode: false,
          ),
        ) {
    _subscription = _repository.rxChatStreams.listen(
      (event) {
        _interiorSubscription?.cancel();
        _interiorSubscription = event.listen(
          (chat) {
            emit(
              MessageControlState.defaultMode(
                messages: chat.messages,
                selected: IMap(),
                message: MessageModel(),
                isSelectMode: false,
                isEditMode: false,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryInterface _repository;
  late StreamSubscription<ValueStream<ChatModel>> _subscription;
  StreamSubscription<ChatModel>? _interiorSubscription;

  int selectedCount = 0;
  bool _fromDismissible = false;

  @override
  Future<void> close() {
    _subscription.cancel();
    _interiorSubscription?.cancel();

    return super.close();
  }

  void selectOne(MessageModel message) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        selectedCount++;
        emit(
          MessageControlState.manageMode(
            messages: defaultMode.messages,
            selected: IMap({message.id: true}),
            message: MessageModel(),
            selectedCount: selectedCount,
            isSelectMode: true,
            isEditMode: false,
          ),
        );
      },
      manageMode: (manageMode) {
        if (manageMode.selected.containsKey(message.id) &&
            manageMode.selected[message.id]!) {
          unselectOne(message);
        } else {
          selectedCount++;
          emit(
            manageMode.copyWith(
              selected: manageMode.selected.containsKey(message.id)
                  ? manageMode.selected.update(message.id, (value) => true)
                  : manageMode.selected.add(message.id, true),
              selectedCount: selectedCount,
            ),
          );
        }
      },
    );
  }

  void unselectOne(MessageModel message) {
    state.mapOrNull(
      manageMode: (manageMode) {
        if (manageMode.selected.length == 1) {
          selectedCount = 0;
          emit(
            MessageControlState.defaultMode(
              messages: manageMode.messages,
              selected: IMap(),
              message: MessageModel(),
              isSelectMode: false,
              isEditMode: false,
            ),
          );
        } else {
          selectedCount--;
          emit(
            manageMode.copyWith(
              selected:
                  manageMode.selected.update(message.id, (value) => false),
              selectedCount: selectedCount,
            ),
          );
        }
      },
    );
  }

  void unselectAll() {
    state.mapOrNull(
      manageMode: (manageMode) {
        selectedCount = 0;
        emit(
          MessageControlState.defaultMode(
            messages: manageMode.messages,
            selected: IMap(),
            message: MessageModel(),
            isSelectMode: false,
            isEditMode: false,
          ),
        );
      },
    );
  }

  void startEditModeFromDismissible(MessageModel message) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        _fromDismissible = true;
        emit(
          MessageControlState.manageMode(
            messages: defaultMode.messages,
            selected: IMap(),
            message: message,
            selectedCount: selectedCount,
            isSelectMode: true,
            isEditMode: true,
          ),
        );
      },
    );
  }

  void startEditMode() {
    state.mapOrNull(
      manageMode: (manageMode) {
        emit(
          state.copyWith(
            message: manageMode.messages.firstWhere(
              (mes) => manageMode.selected.containsKey(mes.id),
            ),
            isEditMode: true,
          ),
        );
      },
    );
  }

  void editMessage(String messageText) {
    state.mapOrNull(
      manageMode: (manageMode) {
        _repository.update(
          _fromDismissible
              ? manageMode.message.copyWith(messageText: messageText)
              : manageMode.messages
                  .firstWhere(
                    (mes) => manageMode.selected.containsKey(mes.id),
                  )
                  .copyWith(
                    messageText: messageText,
                  ),
        );
        _fromDismissible = false;
      },
    );
    unselectAll();
  }

  void removeOne(MessageModel message) {
    _repository.remove(message);
  }

  void removeSelected() {
    state.mapOrNull(
      manageMode: (manageMode) {
        _repository.removeSelected(
          manageMode.messages,
          manageMode.selected,
        );
        emit(
          MessageControlState.defaultMode(
            messages: manageMode.messages,
            selected: IMap(),
            message: MessageModel(),
            isSelectMode: false,
            isEditMode: false,
          ),
        );
      },
    );
    unselectAll();
  }
}
