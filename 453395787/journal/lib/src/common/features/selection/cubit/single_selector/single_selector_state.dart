part of 'single_selector_cubit.dart';

@freezed
class SingleSelectorState<T extends Object> with _$SingleSelectorState<T> {
  const SingleSelectorState._();

  const factory SingleSelectorState({
    required IList<T> items,
    required T? selectedItem,
  }) = _SingleSelectorState;

  bool isSelected(T item) => selectedItem != null && selectedItem == item;
}
