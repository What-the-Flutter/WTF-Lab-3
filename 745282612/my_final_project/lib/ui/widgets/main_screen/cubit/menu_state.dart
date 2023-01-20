import 'package:equatable/equatable.dart';

class MenuState extends Equatable {
  final int index;

  MenuState({
    required this.index,
  });

  MenuState copyWith({
    int? index,
  }) {
    return MenuState(
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [
        index,
      ];
}
