import 'package:bloc/bloc.dart';

import '../../core/util/logger.dart';

class DiaryApplicationObserver extends BlocObserver {
  static const String blocLogger = 'BloC_Output';
  
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    logger('${bloc.runtimeType} $change', blocLogger);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    
    logger('${bloc.runtimeType} $error $stackTrace', blocLogger);
  }
}