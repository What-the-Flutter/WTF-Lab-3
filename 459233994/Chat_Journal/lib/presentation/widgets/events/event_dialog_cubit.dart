import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_dialog_state.dart';

class EventDialogCubit extends Cubit<EventDialogState> {
  EventDialogCubit()
      : super(
          EventDialogState(
            isEdit: false,
            isMove: false,
          ),
        );

  void setEdit() {
    state.isEdit
        ? emit(state.copyWith(isEdit: false))
        : emit(state.copyWith(isEdit: true));
  }

  void setMove() {
    state.isMove
        ? emit(state.copyWith(isMove: false))
        : emit(state.copyWith(isMove: true));
  }
}
