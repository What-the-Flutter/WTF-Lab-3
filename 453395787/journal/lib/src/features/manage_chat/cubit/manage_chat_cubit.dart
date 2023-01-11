import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/models/chat.dart';
import '../../../common/utils/icons.dart';

part 'manage_chat_state.dart';

part 'manage_chat_cubit.freezed.dart';

class ManageChatCubit extends Cubit<ManageChatState> {
  ManageChatCubit({
    required this.repository,
    required ManageChatState manageChatState,
  }) : super(manageChatState);

  final ChatRepositoryApi repository;

  void onIconSelected(int? id) {
    emit(state.copyWith(selectedIcon: id));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void applyChanges() {
    state.map(
      adding: (adding) {
        repository.add(
          Chat(
            id: Random().nextInt(1000),
            icon: JournalIcons.icons[state.selectedIcon!],
            messages: IList([]),
            name: adding.name,
          ),
        );
      },
      editing: (editing) {
        repository.update(
          editing.chat.copyWith(
            icon: JournalIcons.icons[state.selectedIcon!],
            name: state.name,
          ),
        );
      },
    );
  }
}
