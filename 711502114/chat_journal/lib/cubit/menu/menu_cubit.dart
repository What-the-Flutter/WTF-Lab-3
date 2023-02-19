import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<int> {
  MenuCubit() : super(0);

  void choosePage(int pageIndex) => emit(pageIndex);
}
