import 'package:flutter_bloc/flutter_bloc.dart';

part 'searching_page_state.dart';

class SearchingPageCubit extends Cubit<SearchingPageState> {
  SearchingPageCubit() : super(const SearchingPageState());

  void updateInput(String value) {
    emit(
      state.copyWith(
        newInput: value,
      ),
    );
  }
}
