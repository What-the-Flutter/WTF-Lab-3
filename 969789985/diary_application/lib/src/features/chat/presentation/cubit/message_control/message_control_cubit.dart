import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/interfaces/message_repository_interface.dart';
import '../../../domain/message_model.dart';

part 'message_control_state.dart';

part 'message_control_cubit.freezed.dart';

class MessageControlCubit extends Cubit<MessageControlState> {
  MessageControlCubit({
    required MessageRepositoryInterface provider,
  })  : _provider = provider,
        super(
          MessageControlState.defaultMode(
            messages: IList([]),
            selected: IMap(),
            message: MessageModel(),
            selectedCount: 0,
            isSelectMode: false,
            isEditMode: false,
          ),
        ) {
    _subscription = _provider.rxChatStreams.listen(
      (event) {
        _interiorSubscription?.cancel();
        _interiorSubscription = event.listen(
          (messages) {
            emit(
              MessageControlState.defaultMode(
                messages: messages,
                selected: IMap(),
                message: MessageModel(),
                selectedCount: 0,
                isSelectMode: false,
                isEditMode: false,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryInterface _provider;
  late final StreamSubscription<ValueStream<IList<MessageModel>>> _subscription;
  StreamSubscription<IList<MessageModel>>? _interiorSubscription;

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
        emit(
          MessageControlState.manageMode(
            messages: defaultMode.messages,
            selected: IMap({message.id: true}),
            message: MessageModel(),
            selectedCount: defaultMode.selectedCount + 1,
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
          emit(
            manageMode.copyWith(
              selected: manageMode.selected.containsKey(message.id)
                  ? manageMode.selected.update(message.id, (value) => true)
                  : manageMode.selected.add(message.id, true),
              selectedCount: manageMode.selectedCount + 1,
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
          emit(
            MessageControlState.defaultMode(
              messages: manageMode.messages,
              selected: IMap(),
              message: MessageModel(),
              selectedCount: 0,
              isSelectMode: false,
              isEditMode: false,
            ),
          );
        } else {
          emit(
            manageMode.copyWith(
              selected:
                  manageMode.selected.update(message.id, (value) => false),
              selectedCount: manageMode.selectedCount - 1,
            ),
          );
        }
      },
    );
  }

  void unselectAll() {
    state.mapOrNull(
      manageMode: (manageMode) {
        emit(
          MessageControlState.defaultMode(
            messages: manageMode.messages,
            selected: IMap(),
            message: MessageModel(),
            selectedCount: 0,
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
            selectedCount: 0,
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
        _provider.updateMessage(
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
    _provider.deleteMessage(message);
  }

  void removeSelected() {
    _provider.deleteSelected(state.messages, state.selected);
    unselectAll();
  }
}
