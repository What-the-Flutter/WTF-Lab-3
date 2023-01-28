import 'package:equatable/equatable.dart';

class MenuState extends Equatable {
  final int index;
  final String menuStatus;

  MenuState({
    required this.index,
    required this.menuStatus,
  });

  MenuState copyWith({
    int? index,
    String? menuStatus,
  }) {
    return MenuState(
      index: index ?? this.index,
      menuStatus: menuStatus ?? this.menuStatus,
    );
  }

  @override
  List<Object?> get props => [
        index,
        menuStatus,
      ];
}
