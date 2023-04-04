import 'package:diary_application/domain/repository/settings_repository_api.dart';
import 'package:diary_application/domain/utils/finger_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final SettingsRepositoryApi _rep;

  bool get isAuthenticated => state.isAuthenticated;

  bool get tryingUnlock => state.tryingUnlock;

  MenuCubit({required SettingsRepositoryApi rep})
      : _rep = rep,
        super(const MenuState(isLocked: true)) {
    _init();
  }

  void _init() async {
    final bool isAuth;
    if (!state.isAuthenticated && await _rep.isLocked) {
      isAuth = await FingerAuth.check();
    } else {
      isAuth = true;
    }
    emit(state.copyWith(isAuthenticated: isAuth, tryingUnlock: false));
  }

  void choosePage(int pageIndex) => emit(state.copyWith(pageIndex: pageIndex));

  Future<void> authenticate() async {
    emit(state.copyWith(tryingUnlock: true));
    final isAuth = await FingerAuth.check();
    emit(state.copyWith(isAuthenticated: isAuth, tryingUnlock: false));
  }
}
