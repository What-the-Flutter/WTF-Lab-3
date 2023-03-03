import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/api_settings_repository.dart';
import '../../../domain/services/fingerptint_auth.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final ApiSettingsRepository _settingsRepository;

  AppCubit({required ApiSettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(const AppState(isLocked: true)) {
    _init();
  }

  bool get isAuthenticated => state.isAuthenticated;

  void _init() async {
    final bool isAuth;
    if (!state.isAuthenticated && await _settingsRepository.isLocked) {
      isAuth = await FingerPrintAuth.authenticate();
    } else {
      isAuth = true;
    }
    emit(state.copyWith(isAuthenticated: isAuth, tryingUnlock: false));
  }

  Future<void> authenticate() async {
    emit(state.copyWith(tryingUnlock: true));
    final isAuth = await FingerPrintAuth.authenticate();
    emit(state.copyWith(isAuthenticated: isAuth, tryingUnlock: false));
  }

  bool get tryingUnlock => state.tryingUnlock;
}
