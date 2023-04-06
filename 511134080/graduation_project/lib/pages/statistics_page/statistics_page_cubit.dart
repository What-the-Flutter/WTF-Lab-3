import 'package:flutter_bloc/flutter_bloc.dart';

part 'statistics_page_state.dart';

class StatisticsPageCubit extends Cubit<StatisticsPageState> {
  StatisticsPageCubit() : super(StatisticsPageState());

  void changeSelectedIndex(int value) => emit(
        state.copyWith(
          changedSelectedIndex: value,
        ),
      );

  void changeTimeOption(String? value) => emit(
        state.copyWith(
          newTimeOption: value,
        ),
      );

  void toggleShowingOptions({String? option}) => emit(
        state.copyWith(
          newTimeOption: option,
          showingOptions: !state.isShowingOptions,
        ),
      );
}
