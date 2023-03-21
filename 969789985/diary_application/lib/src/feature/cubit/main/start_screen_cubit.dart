import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/logger.dart';

part 'start_screen_state.dart';

part 'start_screen_cubit.freezed.dart';

class StartScreenCubit extends Cubit<StartScreenState> {
  StartScreenCubit()
      : super(
          const StartScreenState(
            pageIndex: 0,
            fabVisible: true,
            gNavVisible: true,
            hashtag: '',
          ),
        );

  set pageIndex(int pageIndex) {
    logger('Current page index: $pageIndex', 'Page_index');

    emit(
      state.copyWith(
        pageIndex: pageIndex,
      ),
    );
  }

  set gNavVisible(bool value) {
    emit(
      state.copyWith(
        gNavVisible: value,
      ),
    );
  }

  set fabVisible(bool value) {
    emit(
      state.copyWith(
        fabVisible: value,
      ),
    );
  }

  set hashtag(String hashtag) {
    emit(
      state.copyWith(
        hashtag: hashtag,
      ),
    );
  }
}
