import 'package:equatable/equatable.dart';

enum MenuStatus { home, timeline }

class MenuState extends Equatable {
  final int index;
  final MenuStatus menuStatus;

  MenuState({
    required this.index,
    required this.menuStatus,
  });

  MenuState copyWith({
    int? index,
    MenuStatus? menuStatus,
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
