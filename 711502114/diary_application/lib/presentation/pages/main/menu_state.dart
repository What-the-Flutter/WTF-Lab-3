import 'package:equatable/equatable.dart';

class MenuState extends Equatable {
  final bool isAuthenticated;
  final bool isLocked;
  final int pageIndex;
  final bool tryingUnlock;

  const MenuState({
    required this.isLocked,
    this.isAuthenticated = false,
    this.pageIndex = 0,
    this.tryingUnlock = true,
  });

  MenuState copyWith({
    bool? isLocked,
    bool? isAuthenticated,
    int? pageIndex,
    bool? tryingUnlock,
  }) {
    return MenuState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      pageIndex: pageIndex ?? this.pageIndex,
      isLocked: isLocked ?? this.isLocked,
      tryingUnlock: tryingUnlock ?? this.tryingUnlock,
    );
  }

  @override
  List<Object?> get props => [
        isAuthenticated,
        pageIndex,
        isLocked,
        tryingUnlock,
      ];
}
