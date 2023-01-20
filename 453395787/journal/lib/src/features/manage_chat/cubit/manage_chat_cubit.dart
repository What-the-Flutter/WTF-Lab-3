import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/repository/chat_repository_api.dart';
import '../../../common/models/db/db_chat.dart';
import '../../../common/models/ui/chat.dart';
import '../../../common/utils/icons.dart';

part 'manage_chat_state.dart';

part 'manage_chat_cubit.freezed.dart';

class ManageChatCubit extends Cubit<ManageChatState> {
  ManageChatCubit({
    required ChatRepositoryApi chatRepository,
    required ManageChatState manageChatState,
  }) : _repository = chatRepository,
        super(manageChatState);

  final ChatRepositoryApi _repository;

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
        _repository.add(
          Chat(
            id: '',
            icon: JournalIcons.icons[state.selectedIcon!],
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
        _repository.update(
          editModeState.chat.copyWith(
            icon: JournalIcons.icons[state.selectedIcon!],
            name: state.name,
          ),
        );
      },
    );
  }
}
