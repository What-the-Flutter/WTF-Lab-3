import 'package:flutter_bloc/flutter_bloc.dart';

import 'creation_state.dart';

class CreationCubit extends Cubit<CreationState> {
  CreationCubit() : super(CreationState(index: 0, isFinished: false));

  void reset() {
    emit(state.copyWith(index: 0, isFinished: false, isEditMode: false));
  }

  void setEditDefault({required int index, required bool editMode}) {
    emit(state.copyWith(index: index, isFinished: true, isEditMode: editMode));
  }

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  void changeFinishStatus(bool isFinished) {
    emit(state.copyWith(isFinished: isFinished));
  }
}
