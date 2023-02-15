import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool isAuthenticated;
  final bool isLocked;
  final int pageIndex;
  final String title;

  const AppState({
    this.isAuthenticated = false,
    this.pageIndex = 0,
    this.title = 'Home',
    required this.isLocked,
  });

  AppState copyWith({
    bool? isLocked,
    bool? isAuthenticated,
    int? pageIndex,
    String? title,
  }) {
    return AppState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      pageIndex: pageIndex ?? this.pageIndex,
      title: title ?? this.title,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, pageIndex, title, isLocked];
}
