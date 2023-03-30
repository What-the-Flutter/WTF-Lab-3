import 'package:bloc/bloc.dart';

import '../../providers/settings_provider.dart';
import '../../services/fingerprint_aythentication.dart';
import '../../services/firebase_authentication.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final SettingsProvider _settingsProvider;
  final FirebaseAuthentication _firebaseAuthentication;
  final FingerprintAuthentication _fingerprintAuthentication;

  AppCubit({
    required SettingsProvider provider,
  })  : _firebaseAuthentication = FirebaseAuthentication(),
        _fingerprintAuthentication = FingerprintAuthentication(),
        _settingsProvider = provider,
        super(AppState()) {
    init();
  }

  Future<void> init() async {
    await _firebaseAuthentication.authenticateAnonymously();
  }

  Future<void> authenticateLocal() async {
    final bool didAuthenticate;
    final useFingerprint = await _settingsProvider.useFingerprint ?? false;
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
