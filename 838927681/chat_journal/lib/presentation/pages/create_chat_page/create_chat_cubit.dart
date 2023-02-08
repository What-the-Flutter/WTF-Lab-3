import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/repositories/api_chat_repository.dart';
import '../home_page/home_page_state.dart';
import 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  final ApiChatRepository chatRepository;

  CreateChatCubit({
    required this.chatRepository,
    required bool isCreatingMode,
    int selectedIcon = 0,
  }) : super(
          CreateChatState(
            selectedIconIndex: selectedIcon,
            isNotEmpty: false,
            isCreatingMode: isCreatingMode,
            isChanged: false,
          ),
        );

  void changeSelectedIconIndex(int index) {
    emit(state.copyWith(selectedIconIndex: index));
  }

  void changeIsNotEmpty(bool value) {
    emit(state.copyWith(isNotEmpty: value));
  }

  void isChangedToTrue() {
    emit(state.copyWith(isChanged: true));
  }

  void setToEdit(Chat chat) {
    emit(
      state.copyWith(
        isCreatingMode: false,
        selectedIconIndex: chat.iconIndex,
      ),
    );
  }

  void reset() {
    emit(
      state.copyWith(
        selectedIconIndex: 0,
        isCreatingMode: true,
        isChanged: false,
      ),
    );
  }

  void incrementCounterId() {
    final newId = state.counterId + 1;
    emit(state.copyWith(counterId: newId));
  }

  int generateId(HomePageState homeState) {
    var counterId = state.counterId;
    var generated = false;
    while (!generated) {
      var exist = false;
      var i = 0;
      while (i < homeState.chats.length && !exist) {
        if (homeState.chats[i].id == counterId) {
          exist = true;
        } else {
          i++;
        }
      }
      if (!exist) {
        generated = true;
      }
      counterId++;
    }
    emit(state.copyWith(counterId: counterId));
    return state.counterId;
  }

  Future<void> addChat(Chat chat) async {
    await chatRepository.addChat(chat);
  }
}
