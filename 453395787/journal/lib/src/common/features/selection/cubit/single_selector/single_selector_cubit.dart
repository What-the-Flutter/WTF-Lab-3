import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_selector_state.dart';

part 'single_selector_cubit.freezed.dart';

class SingleSelectorCubit<T extends Object>
    extends Cubit<SingleSelectorState<T>> {
  SingleSelectorCubit({
    required IList<T> items,
    required T? selectedItem,
  }) : super(
          SingleSelectorState<T>(
            items: items,
            selectedItem: selectedItem,
          ),
        );

  void toggleSelection(T item) {
    if (state.selectedItem == item) {
      emit(
        state.copyWith(selectedItem: null),
      );
    } else {
      emit(
        state.copyWith(
          selectedItem: item,
        ),
      );
    }
  }

  void reset() {
    emit(
      state.copyWith(
        selectedItem: null,
      ),
    );
  }
}
