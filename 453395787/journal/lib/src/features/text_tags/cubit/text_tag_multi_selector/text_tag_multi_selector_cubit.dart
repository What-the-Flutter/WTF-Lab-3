import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../api/text_tag_repository_api.dart';
import '../../model/text_tag.dart';

part 'text_tag_multi_selector_state.dart';

part 'text_tag_multi_selector_cubit.freezed.dart';

class TextTagMultiSelectorCubit extends Cubit<TextTagMultiSelectorState> {
  TextTagMultiSelectorCubit({
    required TextTagRepositoryApi textTagRepository,
    IList<String>? selectedIds,
  }) : super(
          TextTagMultiSelectorState(
            tags: textTagRepository.textTags.value,
            selectedIds: selectedIds ?? IList([]),
          ),
        );

  void setSelected(IList<String> selectedIds) {
    emit(
      state.copyWith(
        selectedIds: selectedIds,
      ),
    );
  }

  void toggleSelection(TextTag tag) {
    if (state.isSelected(tag)) {
      _unselect(tag);
    } else {
      _select(tag);
    }
  }

  void _select(TextTag tag) {
    emit(
      state.copyWith(
        selectedIds: state.selectedIds.add(tag.id),
      ),
    );
  }

  void _unselect(TextTag tag) {
    emit(
      state.copyWith(
        selectedIds: state.selectedIds.remove(tag.id),
      ),
    );
  }
}
