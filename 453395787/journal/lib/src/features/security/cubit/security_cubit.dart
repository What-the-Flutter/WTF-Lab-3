import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

import '../data/security_repository_api.dart';

part 'security_state.dart';

part 'security_cubit.freezed.dart';

class SecurityCubit extends Cubit<SecurityState> {
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
  final Logger _log = Logger();

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
      _log.e('_verifyWithFingerprint', error, stack);
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
      _log.e('_verifyWithFingerprint', error, stack);
    }
  }

  void _noVerification() {
    emit(
      const SecurityState.success(),
    );
  }
}
