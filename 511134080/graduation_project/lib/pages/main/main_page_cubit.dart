import 'package:bloc/bloc.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageState());

  void changeSelectedIndex(int newIndex) {
    emit(
      state.copyWith(
        newSelectedIndex: newIndex,
      ),
    );
  }

  void startLoading() {
    emit(
      state.copyWith(
        loaded: true,
      ),
    );
    Future.delayed(
      const Duration(
        seconds: 5,
      ),
    ).then(
      (_) => emit(
        state.copyWith(
          loaded: false,
        ),
      ),
    );
  }
}
