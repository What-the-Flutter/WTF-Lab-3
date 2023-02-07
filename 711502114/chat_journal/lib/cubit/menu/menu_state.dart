import 'package:equatable/equatable.dart';

class MenuState extends Equatable {
  final int pageIndex;

  MenuState(this.pageIndex);

  MenuState copyWith(int? pageIndex) {
    return MenuState(pageIndex ?? this.pageIndex);
  }

  @override
  List<Object?> get props => [pageIndex];
}
