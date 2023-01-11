import 'package:bloc/bloc.dart';

class JournalBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    print('<-- Change -->');
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('<-- Error -->');
    print('${bloc.runtimeType} $error $stackTrace');
  }
}
