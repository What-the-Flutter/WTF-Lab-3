import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/data/models/chat.dart';
import '../widgets/chat_icons.dart';

part 'manage_chat_state.dart';

class ManageChatCubit extends Cubit<ManageChatState> {
  final ChatRepositoryApi repository;

  ManageChatCubit({
    required ManageChatState manageChatState,
    required this.repository,
  }) : super(manageChatState);

  void closePage() {
    emit(const ManageChatClosed());
  }

  void onIconSelected(int? id) {
    emit(state.copyWith(selectedIcon: id));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onFabPressed() {
    if (state is ManageChatAdding) {
      _addChat();
    } else if (state is ManageChatEditing) {
      _editChat();
    }
    closePage();
  }

  void _addChat() {
    repository.add(
      Chat(
        id: Random().nextInt(1000),
        icon: ChatIcons.icons[state.selectedIcon!],
        messages: IList([]),
        name: state.name,
      ),
    );
  }

  void _editChat() {
    var oldChat = (state as ManageChatEditing).chat;

    repository.update(
      oldChat.copyWith(
        icon: ChatIcons.icons[state.selectedIcon!],
        name: state.name,
      ),
    );
  }
}
