import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/message_repository_api.dart';
import '../../../common/data/models/chat.dart';
import '../../../common/data/models/message.dart';
import '../../../common/utils/extensions.dart';

part 'message_manage_state.dart';
part 'message_manage_cubit.freezed.dart';

class MessageManageCubit extends Cubit<MessageManageState> {
  MessageManageCubit({
    required MessageRepositoryApi repository,
  })  : _repository = repository,
        super(
          const MessageManageState.defaultMode(
            name: '',
            messages: IListConst([]),
          ),
        ) {
    _repository.filteredChatStreams.listen(
      (event) {
        _subscriber?.cancel();
        _subscriber = event.listen(
          (chat) {
            name = chat.name;
            id = chat.id;
            emit(
              MessageManageState.defaultMode(
                name: name,
                messages: chat.messages,
              ),
            );
          },
        );
      },
    );
  }

  final MessageRepositoryApi _repository;

  int id = 0;
  String name = '';

  StreamSubscription<Chat>? _subscriber;

  void select(Message message) {
    state.maybeMap(
      defaultMode: (defaultMode) {
        emit(
          MessageManageState.selectionMode(
            name: name,
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
      orElse: () {},
    );
  }

  void unselect(Message message) {
    state.maybeMap(
      selectionMode: (selectionMode) {
        if (selectionMode.selected.length == 1) {
          emit(
            MessageManageState.defaultMode(
              name: name,
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
      orElse: () {},
    );
  }

  void resetSelection() {
    state.maybeMap(
      selectionMode: (selectionMode) {
        emit(
          MessageManageState.defaultMode(
            name: name,
            messages: selectionMode.messages,
          ),
        );
      },
      orElse: () {},
    );
  }

  void copyToClipboard([Message? message]) {
    state.maybeMap(
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
          var text = selectionMode.messages
              .where((e) => selectionMode.selected.contains(e.id))
              .map((e) => e.text)
              .join('\n');

          Clipboard.setData(ClipboardData(text: text));
        }
        emit(
          MessageManageState.defaultMode(
            name: name,
            messages: selectionMode.messages,
          ),
        );
      },
      orElse: () {},
    );
  }

  void remove([Message? message]) {
    state.maybeMap(
      defaultMode: (defaultMode) {
        if (message != null) {
          _repository.remove(message);
        }
      },
      selectionMode: (selectionMode) {
        var messages = selectionMode.messages
            .where((e) => selectionMode.selected.contains(e.id));
        messages.forEach(_repository.remove);
        emit(
          MessageManageState.defaultMode(
            name: name,
            messages: messages.toIList(),
          ),
        );
      },
      orElse: () {},
    );
  }

  void startEditMode([Message? message]) {
    state.maybeMap(
      defaultMode: (defaultMode) {
        if (message != null) {
          emit(
            MessageManageState.editMode(
              name: name,
              messages: defaultMode.messages,
              message: message,
            ),
          );
        }
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.length == 1) {
          emit(
            MessageManageState.editMode(
              name: name,
              messages: selectionMode.messages,
              message: selectionMode.messages.firstWhere(
                (element) => element.id == selectionMode.selected.first,
              ),
            ),
          );
        }
      },
      orElse: () {},
    );
  }

  void endEditMode() {
    state.maybeMap(
      editMode: (editMode) {
        emit(
          MessageManageState.defaultMode(
            name: name,
            messages: editMode.messages,
          ),
        );
      },
      orElse: () {},
    );
  }

  void addToFavorites([Message? message]) {
    state.maybeMap(
      defaultMode: (defaultMode) {
        if (message != null) {
          _repository.addToFavorites(message);
        }
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.isNotEmpty) {
          var messages = selectionMode.messages
              .where((e) => selectionMode.selected.contains(e.id));
          messages.forEach(_repository.addToFavorites);
        }
      },
      orElse: () {},
    );
  }

  void removeFromFavorites([Message? message]) {
    state.maybeMap(
      defaultMode: (defaultMode) {
        if (message != null) {
          _repository.removeFromFavorites(message);
        }
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.isNotEmpty) {
          var messages = selectionMode.messages
              .where((e) => selectionMode.selected.contains(e.id));
          messages.forEach(_repository.removeFromFavorites);
        }
      },
      orElse: () {},
    );
  }

  void moveMessage(int newChatId, [Message? message]) {
    state.maybeMap(
      defaultMode: (defaultMode) {
        if (message != null) {}
      },
      selectionMode: (selectionMode) {
        if (selectionMode.selected.isNotEmpty) {
          var messages = selectionMode.messages
              .where((e) => selectionMode.selected.contains(e.id));
        }
      },
      orElse: () {},
    );
  }

  void onSearchClick() {}
}
