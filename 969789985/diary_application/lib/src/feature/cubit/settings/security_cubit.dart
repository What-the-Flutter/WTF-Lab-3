import 'dart:convert';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/data/repository/security/security_repository.dart';
import '../../../core/domain/api/security/api_security_repository.dart';
import '../../../core/util/typedefs.dart';

part 'security_cubit.freezed.dart';

part 'security_state.dart';

class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit({
    required ApiSecurityRepository repository,
  })  : _repository = repository,
        super(
          SecurityState.defaultMode(
            securityMode: repository.securityMode,
            passcodeSequence: IList<int>(),
            withBiometric: false,
            isAuth: false,
            isDeviceSupportedBiometric: repository.isDeviceSupportedBiometrics,
            availableBiometric: repository.availableBiometric,
          ),
        );

  final ApiSecurityRepository _repository;

  set securityMode(String value) {
    _repository.setSecurityMode(value);
    emit(
      state.copyWith(
        securityMode: value,
      ),
    );
  }

  Future<bool> authenticate() async => await _repository.authenticate();

  void _updateAuthValue({required bool authValue}) {
    emit(
      state.copyWith(
        isAuth: authValue,
      ),
    );
  }

  void disableSecurityMode() {
    _repository.setSecurityMode(SecurityMode.noneSecurity.securityMode);
    emit(
      state.copyWith(
        securityMode: SecurityMode.noneSecurity.securityMode,
      ),
    );
  }

  void onPasscodeChanged({
    required int passcode,
    required Callback action,
    required bool authValue,
  }) {
    emit(
      state.copyWith(
        passcodeSequence: state.passcodeSequence.add(passcode),
      ),
    );

    if (state.passcodeSequence.length == 4) {
      _updateAuthValue(authValue: authValue);
      if (state.isAuth) {
        _readPasscode(action);
      } else {
        _setPasscode();
        action.call();
      }
    }
  }

  void removeOnePasscodeNumber() {
    if (state.passcodeSequence.isEmpty) return;

    emit(
      state.copyWith(
        passcodeSequence: state.passcodeSequence.remove(
          state.passcodeSequence.last,
        ),
      ),
    );
  }

  void removePasscode() {
    emit(
      state.copyWith(
        passcodeSequence: IList<int>(),
      ),
    );
  }

  void updateBiometricSwitcher(bool value) {
    emit(
      state.copyWith(
        withBiometric: value,
      ),
    );
  }

  void _setPasscode() {
    final passcode = _sha256passcode(
      state.passcodeSequence.join(),
    );

    dev.log('Passcode is $passcode', name: 'Passcode_sequence');

    final securityMode = state.withBiometric
        ? SecurityMode.withPasscodeAndBiometric.securityMode
        : SecurityMode.withPasscode.securityMode;

    _repository.setSecurityMode(securityMode);
    _repository.setPasscode(passcode);

    emit(
      state.copyWith(
        securityMode: securityMode,
        passcodeSequence: IList<int>(),
        isAuth: false,
      ),
    );
  }

  void _readPasscode(Callback action) {
    final passcode = _sha256passcode(
      state.passcodeSequence.join(),
    );

    _logger('Passcode hash is $passcode', 'Entered_passcode');

    _logger('Preferences passcode is ${_repository.passcode}', 'Set_passcode');

    if (passcode == _repository.passcode) {
      action.call();
    } else {
      _logger('123', '32132132132');
    }

    emit(
      state.copyWith(
        passcodeSequence: IList<int>(),
        isAuth: false,
      ),
    );
  }

  void _logger(String message, String tag) => dev.log(message, name: tag);

  String _sha256passcode(String passcode) {
    return sha256.convert(utf8.encode(passcode)).toString();
  }
}
