import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/firebase_authentication.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final FirebaseAuthentication _firebaseAuthentication;

  AppCubit()
      : _firebaseAuthentication = FirebaseAuthentication(),
        super(AppState()) {
    init();
  }

  Future<void> init() async {
    await _firebaseAuthentication.authenticateAnonymously();
  }
}
