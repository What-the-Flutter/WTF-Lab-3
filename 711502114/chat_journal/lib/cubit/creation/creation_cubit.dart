import 'package:flutter_bloc/flutter_bloc.dart';

import 'creation_state.dart';

class CreationCubit extends Cubit<CreationState> {
  CreationCubit() : super(CreationState(index: 0, isFinished: false));

  void reset() {
    emit(state.copyWith(index: 0, isFinished: false));
  }

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  void changeFinishStatus(bool isFinished) {
    emit(state.copyWith(isFinished: isFinished));
  }
}
