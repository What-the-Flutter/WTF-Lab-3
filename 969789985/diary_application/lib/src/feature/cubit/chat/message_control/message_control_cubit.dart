import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/api/message/api_message_repository.dart';
import '../../../../core/domain/api/tag/api_tag_repository.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/domain/models/local/tag/tag_model.dart';
import '../../../../core/util/typedefs.dart';

part 'message_control_cubit.freezed.dart';

part 'message_control_state.dart';

class MessageControlCubit extends Cubit<MessageControlState> {
  MessageControlCubit({
    required ApiMessageRepository repository,
    required ApiTagRepository tagRepository,
    required FId chatId,
  })  : _repository = repository,
        _tagRepository = tagRepository,
        _chatId = chatId,
        super(
          MessageControlState.defaultMode(
            messages: IList([]),
            selected: IMap(),
            message: MessageModel(),
            selectedCount: 0,
            isSelectMode: false,
            isEditMode: false,
            isFavoriteMode: false,
          ),
        ) {
    _subscription = repository.rxChatStreams.listen(
      (messages) {
        emit(
          MessageControlState.defaultMode(
            messages: messages.sort(
              (a, b) => a.sendDate.compareTo(b.sendDate),
            ),
            selected: IMap(),
            message: MessageModel(),
            selectedCount: 0,
            isSelectMode: false,
            isEditMode: false,
            isFavoriteMode: false,
          ),
        );
      },
    );
  }

  final FId _chatId;

  final ApiMessageRepository _repository;
  final ApiTagRepository _tagRepository;
  late final StreamSubscription<IList<MessageModel>> _subscription;

  bool _fromDismissible = false;

  @override
  Future<void> close() {
    _subscription.cancel();

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
            isFavoriteMode: defaultMode.isFavoriteMode,
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
              isFavoriteMode: manageMode.isFavoriteMode,
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
            isFavoriteMode: manageMode.isFavoriteMode,
          ),
        );
      },
    );
  }

  void startFavoriteMode() {
    state.map(
      defaultMode: (defaultMode) {
        emit(
          defaultMode.copyWith(
            isFavoriteMode: true,
          ),
        );
      },
      manageMode: (manageMode) {
        emit(
          manageMode.copyWith(
            isFavoriteMode: true,
          ),
        );
      },
    );
  }

  void endFavoriteMode() {
    state.map(
      defaultMode: (defaultMode) {
        emit(
          defaultMode.copyWith(
            isFavoriteMode: false,
          ),
        );
      },
      manageMode: (manageMode) {
        emit(
          manageMode.copyWith(
            isFavoriteMode: false,
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
            isFavoriteMode: defaultMode.isFavoriteMode,
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
        _repository.updateMessage(
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
    _repository.deleteMessage(message);
  }

  void removeSelected() {
    final messages = state.selected.keys
        .map(
          (key) => state.messages.firstWhere(
            (mes) => state.selected[key] == true && mes.id == key,
          ),
        )
        .toIList();

    _repository.deleteSelected(messages);
  }

  void addToFavorites() {
    final messages = state.selected.keys
        .map(
          (key) => state.messages.firstWhere(
            (mes) => state.selected[key] == true && mes.id == key,
          ),
        )
        .toIList();

    _repository.addToFavorites(messages);
  }

  void removeFromFavorites() {
    final messages = state.selected.keys
        .map(
          (key) => state.messages.firstWhere(
            (mes) => state.selected[key] == true && mes.id == key,
          ),
        )
        .toIList();

    _repository.removeFromFavorites(messages);
  }
}
