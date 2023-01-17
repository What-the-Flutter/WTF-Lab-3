import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class JournalBlocObserver extends BlocObserver {
  static final Logger log = Logger();

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
