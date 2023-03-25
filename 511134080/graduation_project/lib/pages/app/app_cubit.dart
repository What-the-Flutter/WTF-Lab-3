import 'package:bloc/bloc.dart';

import '../../services/firebase_authentication.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final FirebaseAuthentication firebaseAuthentication;
  AppCubit()
      : firebaseAuthentication = FirebaseAuthentication(),
        super(AppState()) {
    init();
  }

  void init() {
    firebaseAuthentication.authenticateAnonymously();
  }
}
