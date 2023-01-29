part of 'multi_selector_cubit.dart';

@freezed
class MultiSelectorState<T extends Object> with _$MultiSelectorState<T> {
  const MultiSelectorState._();

  const factory MultiSelectorState({
    required IList<T> items,
    required ISet<T> selectedItems,
  }) = _MultiSelectorState;

  bool isSelected(T item) {
    // Not using default ISet.contains() because it throws exception:
    // Type '...' is not a subtype of the 'Null' of element.
    for (var selectedItem in selectedItems) {
      if (item == selectedItem) return true;
    }
    return false;
  }

  bool get hasSelected => selectedItems.isNotEmpty;
}
