import 'package:bloc/bloc.dart';

import '../utils/app_logger.dart';

class JournalBlocObserver extends BlocObserver with AppLogger {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.v('${bloc.runtimeType} => $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log.e('${bloc.runtimeType} => ', error, stackTrace);
  }
}
