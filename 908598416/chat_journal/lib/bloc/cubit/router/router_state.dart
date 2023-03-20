part of 'router_cubit.dart';

abstract class RouterState extends Equatable {
  const RouterState();

  @override
  List<Object?> get props => [];
}

class Page1State extends RouterState {
  final String? extraPageContent;

  const Page1State([this.extraPageContent]);

  @override
  List<Object?> get props => [extraPageContent];
}

class Page2State extends RouterState {
  final String? extraPageContent;

  const Page2State([this.extraPageContent]);

  @override
  List<Object?> get props => [extraPageContent];
}

class Page3State extends RouterState {
  final String? extraPageContent;

  const Page3State([this.extraPageContent]);

  @override
  List<Object?> get props => [extraPageContent];
}

class Page4State extends RouterState {
  final String? extraPageContent;

  const Page4State([this.extraPageContent]);

  @override
  List<Object?> get props => [extraPageContent];
}
