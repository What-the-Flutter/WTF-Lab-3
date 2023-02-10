import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/data/db/firebase_provider.dart';
import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_state.dart';

class TimelineCubit extends Cubit<TimelineState> {
  final User? user;
  late final firebase = FirebaseProvider(user: user);

  TimelineCubit({this.user})
      : super(
          TimelineState(
            filterList: [],
            filterChat: [],
            filterTags: [],
            filterSection: [],
            filterDateTime: null,
          ),
        );

  Future<void> initializer() async {
    final listEvent = await firebase.getAllEvent();
    emit(state.copyWith(filterList: listEvent));
  }

  void changeFilterPages(int chatId) {
    final index = state.filterChat.indexWhere((element) => element == chatId);
    if (index == -1) {
      emit(state.copyWith(filterChat: [...state.filterChat, chatId]));
    } else {
      emit(
        state.copyWith(
          filterChat: [...state.filterChat]..removeWhere((element) => element == chatId),
        ),
      );
    }
  }

  void changeFilterTags(String tag) {
    final index = state.filterTags.indexWhere((element) => element == tag);
    if (index == -1) {
      emit(state.copyWith(filterTags: [...state.filterTags, tag]));
    } else {
      emit(
        state.copyWith(
          filterTags: [...state.filterTags]..removeWhere((element) => element == tag),
        ),
      );
    }
  }

  void changeFilterSection(String sectionId) {
    final index = state.filterSection.indexWhere((element) => element == sectionId);
    if (index == -1) {
      emit(state.copyWith(filterSection: [...state.filterSection, sectionId]));
    } else {
      emit(
        state.copyWith(
          filterSection: [...state.filterSection]..removeWhere((element) => element == sectionId),
        ),
      );
    }
  }

  void changeFilterDateTime(DateTime dateTime) {
    final filterDateTime = dateTime;
    emit(state.copyWith(filterDateTime: filterDateTime));
  }

  void resetFilter() {
    emit(
      state.copyWith(
        filterChat: [],
        filterSection: [],
        filterTags: [],
        filterList: [],
        filterDateTime: null,
        searchText: '',
        onlyPicture: false,
      ),
    );
  }

  void changeFavoriteStatus() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  Future<void> filterEventList() async {
    final allEvent = await firebase.getAllEvent();
    final filterEventList = allEvent;
    if (state.filterChat.isEmpty &&
        state.filterSection.isEmpty &&
        state.filterTags.isEmpty &&
        state.filterDateTime == null &&
        state.searchText == '' &&
        state.onlyPicture == false) {
      emit(state.copyWith(filterList: []));
    } else {
      if (state.filterChat.isNotEmpty) {
        filterEventList.removeWhere((element) => !state.filterChat.contains(element.chatId));
      }
      if (state.filterSection.isNotEmpty) {
        filterEventList
            .removeWhere((element) => !state.filterSection.contains(element.sectionTitle));
      }
      if (state.filterTags.isNotEmpty) {
        filterEventList.removeWhere((element) => !state.filterTags.contains(element.tag));
      }
      if (state.filterDateTime != null) {
        filterEventList.removeWhere((element) =>
            DateFormat.yMd().format(element.messageTime) !=
            DateFormat.yMd().format(state.filterDateTime!));
      }
      if (state.searchText != '') {
        filterEventList.removeWhere((element) =>
            !element.messageContent.toLowerCase().contains(state.searchText.toLowerCase()));
      }
      if (state.onlyPicture != false) {
        filterEventList.removeWhere((element) => element.messageImage == null);
      }
      emit(state.copyWith(filterList: filterEventList));
    }
  }

  List<Event> filterFavoriteList() {
    return state.filterList.reversed.where((element) => element.isFavorit).toList();
  }

  void changeStatusImage() {
    if (state.onlyPicture == false) {
      emit(state.copyWith(onlyPicture: true));
    } else {
      emit(state.copyWith(onlyPicture: false));
    }
  }

  void searchText(String text) {
    emit(state.copyWith(searchText: text));
  }

  bool isSelectedSection(String sectionId) => state.filterSection.contains(sectionId);
  bool isSelectedTag(String tagId) => state.filterTags.contains(tagId);
  bool isSelectedChat(int chatId) => state.filterChat.contains(chatId);
  bool isSelectedDataTime() => state.filterDateTime != null;
}
