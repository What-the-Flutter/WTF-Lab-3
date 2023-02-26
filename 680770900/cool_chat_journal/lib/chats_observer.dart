import 'package:bloc/bloc.dart';

class ChatsObserver extends BlocObserver {
  const ChatsObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    print('${bloc.runtimeType} $change');
  }
}