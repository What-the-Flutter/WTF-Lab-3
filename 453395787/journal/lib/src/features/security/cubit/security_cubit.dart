import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';

import '../../../common/utils/app_logger.dart';
import '../data/security_repository_api.dart';
import '../utils/verify_method_enum.dart';

part 'security_state.dart';

part 'security_cubit.freezed.dart';

class SecurityCubit extends Cubit<SecurityState> with AppLogger {
  SecurityCubit({
    required SecurityRepositoryApi securityRepository,
  })  : _securityRepository = securityRepository,
        super(
          SecurityState.initial(
            verifyMethod: securityRepository.verifyMethod,
          ),
        ) {
    if (securityRepository.verifyMethod == VerifyMethod.none) {
      emit(const SecurityState.success());
    }
  }

  final SecurityRepositoryApi _securityRepository;
  final LocalAuthentication _auth = LocalAuthentication();

  Future<void> verify() async {
    state.mapOrNull(
      initial: (initial) async {
        switch (initial.verifyMethod) {
          case VerifyMethod.none:
            return _noVerification();
          case VerifyMethod.fingerprint:
            return _verifyWithFingerprint();
          case VerifyMethod.faceId:
            return _verifyWithFace();
        }
      },
    );
  }

  Future<void> _verifyWithFingerprint() async {
    try {
      final hasAccess = await _auth.authenticate(
        localizedReason: 'Confirm it\'s you to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if (hasAccess) {
        emit(
          const SecurityState.success(),
        );
      }
    } on PlatformException catch (error, stack) {
      log.e('_verifyWithFingerprint', error, stack);
    }
  }

  Future<void> _verifyWithFace() async {
    try {
      final hasAccess = await _auth.authenticate(
        localizedReason: 'Confirm it\'s you to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if (hasAccess) {
        emit(
          const SecurityState.success(),
        );
      }
    } on PlatformException catch (error, stack) {
      log.e('_verifyWithFingerprint', error, stack);
    }
  }

  void _noVerification() {
    emit(
      const SecurityState.success(),
    );
  }

  Future<void> resetToDefault() async {
    await _securityRepository.resetToDefault();
  }
}
