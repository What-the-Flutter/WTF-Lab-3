import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/models/chat_view.dart';
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
      addModeState: (addModeState) {
        final creationDate = DateTime.now();
        repository.add(
          ChatView(
            id: '',
            iconCodePoint: JournalIcons.icons[state.selectedIcon!].codePoint,
            name: addModeState.name,
            messagePreview: 'Write your first message!',
            messagePreviewCreationTime: creationDate,
            messageAmount: 0,
            isPinned: false,
            creationDate: creationDate,
          ),
        );
      },
      editModeState: (editModeState) {
        repository.update(
          editModeState.chat.copyWith(
            iconCodePoint: JournalIcons.icons[state.selectedIcon!].codePoint,
            name: state.name,
          ),
        );
      },
    );
  }
}
