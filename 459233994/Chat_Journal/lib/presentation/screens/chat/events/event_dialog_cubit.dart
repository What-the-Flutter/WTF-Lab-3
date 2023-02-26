import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_dialog_state.dart';

class EventDialogCubit extends Cubit<EventDialogState> {
  EventDialogCubit() : super(EventDialogDefault());

  void setEdit() {
    state is EventDialogEdit
        ? emit(EventDialogDefault())
        : emit(EventDialogEdit());
  }

  void setMove() {
    state is EventDialogMove
        ? emit(EventDialogDefault())
        : emit(EventDialogMove());
  }
}
