import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'router_state.dart';

class RouterCubit extends Cubit<RouterState> {
  /**
   * TODO: connect RouterCubit to BottomNavBar
   */

  RouterCubit() : super(const Page1State());

  void goToPage1([String? text]) => emit(Page1State(text));

  void goToPage2([String? text]) => emit(Page2State(text));

  void goToPage3([String? text]) => emit(Page3State(text));

  void goToPage4([String? text]) => emit(Page4State(text));

  void popExtra() {
    if (state is Page2State) {
      goToPage2();
    } else if (state is Page3State) {
      goToPage3();
    } else if (state is Page4State) {
      goToPage4();
    } else {
      goToPage1();
    }
  }
}
