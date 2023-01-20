import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/extensions/date_time_extensions.dart';
import '../../../../common/models/db/db_message.dart';
import '../../../../common/models/ui/message.dart';
import '../../../../common/models/ui/tag.dart';
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
          MessageManageState.defaultModeState(
            id: chatId,
            name: name,
            messages: messageRepository.messages.value,
            tags: messageRepository.tags.value,
          ),
        ) {
    _messageStreamSub = messageRepository.messages.listen(
      (messages) {
        emit(
          MessageManageState.defaultModeState(
            id: chatId,
            name: name,
            messages: messages,
            tags: messageRepository.tags.value,
          ),
        );
      },
    );
  }

  final MessageRepositoryApi _repository;
  final Id chatId;
  final String name;
  StreamSubscription<IList<Message>>? _messageStreamSub;

  @override
  Future<void> close() async {
    _messageStreamSub?.cancel();
    super.close();
  }

  void select(Message message) {
    state.mapOrNull(
      defaultModeState: (defaultModeState) {
        emit(
          MessageManageState.selectionModeState(
            id: defaultModeState.id,
            name: defaultModeState.name,
            messages: defaultModeState.messages,
            selected: ISet([message.id]),
            tags: _repository.tags.value,
          ),
        );
      },
      selectionModeState: (selectionModeState) {
        emit(
          selectionModeState.copyWith(
            selected: selectionModeState.selected.add(message.id),
          ),
        );
      },
    );
  }

  void unselect(Message message) {
    state.mapOrNull(
      selectionModeState: (selectionModeState) {
        if (selectionModeState.selected.length == 1) {
          emit(
            MessageManageState.defaultModeState(
              id: selectionModeState.id,
              name: selectionModeState.name,
              messages: selectionModeState.messages,
              tags: _repository.tags.value,
            ),
          );
        } else {
          emit(
            selectionModeState.copyWith(
              selected: selectionModeState.selected.remove(message.id),
            ),
          );
        }
      },
    );
  }

  void resetSelection() {
    state.mapOrNull(
      selectionModeState: (selectionModeState) {
        emit(
          MessageManageState.defaultModeState(
            id: selectionModeState.id,
            name: selectionModeState.name,
            messages: selectionModeState.messages,
            tags: _repository.tags.value,
          ),
        );
      },
    );
  }

  void copyToClipboard([Message? message]) {
    state.mapOrNull(
      defaultModeState: (defaultModeState) {
        if (message != null) {
          Clipboard.setData(
            ClipboardData(
              text: message.text,
            ),
          );
        }
      },
      selectionModeState: (selectionModeState) {
        if (selectionModeState.selected.isNotEmpty) {
          final text = selectionModeState.messages
              .where((e) => selectionModeState.selected.contains(e.id))
              .map((e) => e.text)
              .join('\n');

          Clipboard.setData(ClipboardData(text: text));
        }
        emit(
          MessageManageState.defaultModeState(
            id: selectionModeState.id,
            name: selectionModeState.name,
            messages: selectionModeState.messages,
            tags: _repository.tags.value,
          ),
        );
      },
    );
  }

  void remove([Message? message]) {
    state.mapOrNull(
      defaultModeState: (defaultModeState) {
        if (message != null) {
          _repository.remove(message);
        }
      },
      selectionModeState: (selectionModeState) {
        final messages = selectionModeState.messages.where(
          (e) => selectionModeState.selected.contains(e.id),
        );
        messages.forEach(_repository.remove);
      },
    );
  }

  void startEditMode([Message? message]) {
    state.mapOrNull(
      defaultModeState: (defaultModeState) {
        if (message != null) {
          emit(
            MessageManageState.editModeState(
              id: defaultModeState.id,
              name: defaultModeState.name,
              messages: defaultModeState.messages,
              tags: _repository.tags.value,
              message: defaultModeState.messages.firstWhere(
                (m) => m.id == message.id,
              ),
            ),
          );
        }
      },
      selectionModeState: (selectionModeState) {
        if (selectionModeState.selected.length == 1) {
          emit(
            MessageManageState.editModeState(
              id: selectionModeState.id,
              name: selectionModeState.name,
              messages: selectionModeState.messages,
              tags: _repository.tags.value,
              message: selectionModeState.messages.firstWhere(
                (element) => element.id == selectionModeState.selected.first,
              ),
            ),
          );
        }
      },
    );
  }

  void endEditMode() {
    state.mapOrNull(
      editModeState: (editModeState) {
        emit(
          MessageManageState.defaultModeState(
            id: editModeState.id,
            name: editModeState.name,
            messages: state.messages,
            tags: _repository.tags.value,
          ),
        );
      },
    );
  }

  void addToFavorites([Message? message]) {
    state.mapOrNull(
      defaultModeState: (defaultModeState) {
        if (message != null) {
          _repository.addToFavorites(message);
        }
      },
      selectionModeState: (selectionModeState) {
        if (selectionModeState.selected.isNotEmpty) {
          final messages = selectionModeState.messages.where(
            (e) => selectionModeState.selected.contains(e.id),
          );
          messages.forEach(_repository.addToFavorites);
        }
      },
    );
  }

  void removeFromFavorites([Message? message]) {
    state.mapOrNull(
      defaultModeState: (defaultModeState) {
        if (message != null) {
          _repository.removeFromFavorites(message);
        }
      },
      selectionModeState: (selectionModeState) {
        if (selectionModeState.selected.isNotEmpty) {
          final messages = selectionModeState.messages.where(
            (e) => selectionModeState.selected.contains(e.id),
          );
          messages.forEach(_repository.removeFromFavorites);
        }
      },
    );
  }
}
