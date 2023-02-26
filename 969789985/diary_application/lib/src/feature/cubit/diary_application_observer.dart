import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';

class DiaryApplicationObserver extends BlocObserver {
  static const String blocLogger = 'BloC_Output';
  
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    dev.log('${bloc.runtimeType} $change', name: blocLogger);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    
    dev.log('${bloc.runtimeType} $error $stackTrace', name: blocLogger);
  }
}