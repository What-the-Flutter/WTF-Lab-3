import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_selector_state.dart';

part 'multi_selector_cubit.freezed.dart';

class MultiSelectorCubit<T extends Object> extends Cubit<MultiSelectorState<T>> {
  MultiSelectorCubit({
    required IList<T> items,
    ISet<T>? selectedItems,
  }) : super(
          MultiSelectorState<T>(
            items: items,
            selectedItems: selectedItems ?? const ISetConst({}),
          ),
        );

  void setSelected(ISet<T> items) {
    emit(
      state.copyWith(
        selectedItems: items,
      ),
    );
  }

  void toggleSelection(T item) {
    if (state.isSelected(item)) {
      unselect(item);
    } else {
      select(item);
    }
  }

  void select(T item) {
    emit(
      state.copyWith(
        selectedItems: state.selectedItems.add(item),
      ),
    );
  }

  void unselect(T item) {
    emit(
      state.copyWith(
        selectedItems: state.selectedItems.remove(item),
      ),
    );
  }

  void reset() {
    emit(
      state.copyWith(
        selectedItems: ISet({}),
      ),
    );
  }
}
