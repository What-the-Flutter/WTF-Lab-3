import 'package:bloc/bloc.dart';

import '../../providers/settings_provider.dart';
import '../../services/fingerprint_aythentication.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  final FingerprintAuthentication _fingerprintAuthentication;
  final SettingsProvider _settingsProvider;

  MainPageCubit({
    required SettingsProvider provider,
  })  : _fingerprintAuthentication = FingerprintAuthentication(),
        _settingsProvider = provider,
        super(MainPageState());

  void changeSelectedIndex(int newIndex) {
    emit(
      state.copyWith(
        newSelectedIndex: newIndex,
      ),
    );
  }

  Future<void> authenticateLocal() async {
    final bool didAuthenticate;
    final useFingerprint = await _settingsProvider.useFingerprint;
    if (!state.isAuthenticated && useFingerprint) {
      didAuthenticate = await _fingerprintAuthentication.authenticate();
    } else {
      didAuthenticate = true;
    }

    emit(
      state.copyWith(
        authenticated: didAuthenticate,
      ),
    );
  }

  void logout() {
    emit(
      state.copyWith(
        authenticated: false,
      ),
    );
  }
}
