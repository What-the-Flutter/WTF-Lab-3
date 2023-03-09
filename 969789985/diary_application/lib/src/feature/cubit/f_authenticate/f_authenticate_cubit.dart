import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/repository/authenticate/api_authenticate_repository.dart';

part 'f_authenticate_state.dart';

part 'f_authenticate_cubit.freezed.dart';

class FAuthenticateCubit extends Cubit<FAuthenticateState> {
  final ApiAuthenticateRepository _repository;

  FAuthenticateCubit({
    required ApiAuthenticateRepository repository,
  })  : _repository = repository,
        super(
          const FAuthenticateState.unauthenticated(),
        ) {
    _subscription = _repository.userStream.listen(
      (user) async {
        if (user == null) {
          emit(
            const FAuthenticateState.unauthenticated(),
          );
          _repository.authenticate();
        } else {
          emit(
            FAuthenticateState.authenticate(currentUserId: user.uid),
          );
        }
      },
    );
  }

  late final StreamSubscription<User?> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }
}
