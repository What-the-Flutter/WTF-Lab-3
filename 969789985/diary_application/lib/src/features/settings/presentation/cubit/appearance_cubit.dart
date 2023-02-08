import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appearance_state.dart';

part 'appearance_cubit.freezed.dart';

class AppearanceCubit extends Cubit<AppearanceState> {
  AppearanceCubit()
      : super(
          AppearanceState(
            selectedTags: IMap<int, bool>(),
            selectedIcon: 0,
            tagText: '',
          ),
        ) {
    emit(
      AppearanceState(
        selectedTags: IMap<int, bool>(),
        selectedIcon: 0,
        tagText: '',
      ),
    );
  }

  void onTagTextChanged(String value) {
    emit(
      state.copyWith(
        tagText: value,
      ),
    );
  }

  void selectTagIcon(int index, int codePoint) {
    unselectAll();

    emit(
      state.copyWith(
        selectedTags: state.selectedTags.containsKey(index)
            ? state.selectedTags
                .update(index, (value) => !state.selectedTags[index]!)
            : state.selectedTags.add(index, true),
        selectedIcon: codePoint,
      ),
    );
  }

  void unselectAll() {
    emit(state.copyWith(
      selectedTags: IMap<int, bool>(),
    ));
  }
}
