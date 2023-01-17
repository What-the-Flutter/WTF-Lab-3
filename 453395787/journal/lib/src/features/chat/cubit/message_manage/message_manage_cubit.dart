import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/extensions/date_time_extensions.dart';
import '../../../../common/models/message.dart';
import '../../../../common/utils/typedefs.dart';
import '../../api/message_repository_api.dart';

part 'message_manage_cubit.freezed.dart';

part 'message_manage_state.dart';

class MessageManageCubit extends Cubit<MessageManageState> {
  MessageManageCubit({
    required MessageRepositoryApi messageRepository,
    required this.chatId,
    required this.name,
  })  : _repository = messageRepository,
        super(
          MessageManageState.defaultMode(
            id: chatId,
            name: name,
            messages: messageRepository.filteredChatStreams.value.value,
          ),
        ) {
    _subscription = _repository.filteredChatStreams.listen(
      (event) {
        _internalSubscription?.cancel();
        _internalSubscription = event.listen(
          (messages) {
            emit(
              MessageManageState.defaultMode(
                id: chatId,
                name: name,
                messages: messages,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryApi _repository;
  final int chatId;
  final String name;
  StreamSubscription<MessageList>? _internalSubscription;
  late final StreamSubscription<ValueStream<MessageList>> _subscription;

  @override
  Future<void> close() async {
    _subscription.cancel();
    _internalSubscription?.cancel();
    super.close();
  }

  void select(Message message) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        emit(
          MessageManageState.selectionMode(
            id: defaultMode.id,
            name: defaultMode.name,
            messages: defaultMode.messages,
            selected: ISet([message.id]),
          ),
        );
      },
      selectionMode: (selectionMode) {
        emit(
          selectionMode.copyWith(
            selected: selectionMode.selected.add(message.id),
          ),
        );
      },
    );
  }

  void unselect(Message message) {
    state.mapOrNull(
      selectionMode: (selectionMode) {
        if (selectionMode.selected.length == 1) {
          emit(
            MessageManageState.defaultMode(
              id: selectionMode.id,
              name: selectionMode.name,
              messages: selectionMode.messages,
            ),
          );
        } else {
          emit(
            selectionMode.copyWith(
              selected: selectionMode.selected.remove(message.id),
            ),
          );
        }
      },
    );
  }

  void resetSelection() {
    state.mapOrNull(
      selectionMode: (selectionMode) {
        emit(
          MessageManageState.defaultMode(
            id: selectionMode.id,
            name: selectionMode.name,
            messages: selectionMode.messages,
          ),
        );
      },
    );
  }

  void copyToClipboard([Message? message]) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        if (message != null) {
          Clipboard.setData(
            ClipboardData(
              text: message.text,
            ),
          );
        }
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.isNotEmpty) {
          final text = selectionMode.messages
              .where((e) => selectionMode.selected.contains(e.id))
              .map((e) => e.text)
              .join('\n');

          Clipboard.setData(ClipboardData(text: text));
        }
        emit(
          MessageManageState.defaultMode(
            id: selectionMode.id,
            name: selectionMode.name,
            messages: selectionMode.messages,
          ),
        );
      },
    );
  }

  void remove([Message? message]) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        if (message != null) {
          _repository.remove(message);
        }
      },
      selectionMode: (selectionMode) {
        final messages = selectionMode.messages.where(
          (e) => selectionMode.selected.contains(e.id),
        );
        messages.forEach(_repository.remove);
      },
    );
  }

  void startEditMode([Message? message]) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        if (message != null) {
          emit(
            MessageManageState.editMode(
              id: defaultMode.id,
              name: defaultMode.name,
              messages: defaultMode.messages,
              message: defaultMode.messages.firstWhere(
                (m) => m.id == message.id,
              ),
            ),
          );
        }
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.length == 1) {
          emit(
            MessageManageState.editMode(
              id: selectionMode.id,
              name: selectionMode.name,
              messages: selectionMode.messages,
              message: selectionMode.messages.firstWhere(
                (element) => element.id == selectionMode.selected.first,
              ),
            ),
          );
        }
      },
    );
  }

  void endEditMode() {
    state.mapOrNull(
      editMode: (editMode) {
        emit(
          MessageManageState.defaultMode(
            id: editMode.id,
            name: editMode.name,
            messages: state.messages,
          ),
        );
      },
    );
  }

  void addToFavorites([Message? message]) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        if (message != null) {
          _repository.addToFavorites(message);
        }
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.isNotEmpty) {
          final messages = selectionMode.messages.where(
            (e) => selectionMode.selected.contains(e.id),
          );
          messages.forEach(_repository.addToFavorites);
        }
      },
    );
  }

  void removeFromFavorites([Message? message]) {
    state.mapOrNull(
      defaultMode: (defaultMode) {
        if (message != null) {
          _repository.removeFromFavorites(message);
        }
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.isNotEmpty) {
          final messages = selectionMode.messages.where(
            (e) => selectionMode.selected.contains(e.id),
          );
          messages.forEach(_repository.removeFromFavorites);
        }
      },
    );
  }
}
