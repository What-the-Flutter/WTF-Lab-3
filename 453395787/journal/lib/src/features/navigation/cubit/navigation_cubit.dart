import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/data/models/chat.dart';

part 'navigation_state.dart';
part 'navigation_cubit.freezed.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState.goTo(route: '/'));

  void openHomePage() {
    emit(
      const NavigationState.goTo(route: '/'),
    );
  }

  void openChat(int id) {
    emit(
      NavigationState.goTo(route: '/chat/$id'),
    );
  }

  void openAddChatPage() {
    emit(
      const NavigationState.goTo(route: '/add'),
    );
  }

  void openEditChatPage({required Chat chat}) {
    emit(
      NavigationState.goTo(
        route: '/edit',
        extra: chat,
      ),
    );
  }

  void openSearchPage(int id) {
    emit(
      NavigationState.goTo(route: '/chat/$id/search', extra: id),
    );
  }

  void back() {
    emit(
      const NavigationState.back(),
    );
  }
}
