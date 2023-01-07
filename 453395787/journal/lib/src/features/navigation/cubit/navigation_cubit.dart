import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.dart';
part 'navigation_cubit.freezed.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState.goTo(route: '/'));

  void openHomePage() => emit(const NavigationState.goTo(route: '/'));
  void openChat(int id) => emit(NavigationState.goTo(route: '/chat/$id'));
  void openSearch(int id) => emit(NavigationState.goTo(route: '/chat/$id/search'));
  void back() => emit(const NavigationState.back());
}
