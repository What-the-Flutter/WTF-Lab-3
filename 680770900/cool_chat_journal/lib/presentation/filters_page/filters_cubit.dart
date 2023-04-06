import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import '../../data/repository/repository.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  final ChatsRepository _chatsRepository;
  final TagsRepository _tagsRepository;
  final CategoriesRepository _categoriesRepository;
  
  late final StreamSubscription<List<Chat>> _chatsSubscription;
  late final StreamSubscription<List<Tag>> _tagsSubscription;
  late final StreamSubscription<List<Category>> _categoriesSubscription;

  FiltersCubit(
    this._chatsRepository,
    this._tagsRepository,
    this._categoriesRepository,
  ) : super(const FiltersState()) {
    _chatsSubscription = _chatsRepository.chatsStream.listen(_setChats);
    _tagsSubscription = _tagsRepository.tagsStream.listen(_setTags);
    _categoriesSubscription =
        _categoriesRepository.categoriesStream.listen(_setCategories);
  }

  @override
  Future<void> close() {
    _chatsSubscription.cancel();
    _tagsSubscription.cancel();
    _categoriesSubscription.cancel();
    return super.close();
  }

  void resetFilter() {
    emit(state.copyWith(
      selectedCategories: [],
      selectedChats: [],
      selectedTags: [],
      ignoreSelected: true,
    ));
  }

  void changeChatSelection(Chat chat) {
    final List<Chat> selectedChats;
    if (state.selectedChats.contains(chat)) {
      selectedChats = state.selectedChats.where((e) => e != chat).toList();
    } else {
      selectedChats = List<Chat>.from(state.selectedChats)..add(chat);
    }

    emit(state.copyWith(selectedChats: selectedChats));
  }

  void changeTagSelection(Tag tag) {
    final List<Tag> selectedTags;
    if (state.selectedTags.contains(tag)) {
      selectedTags = state.selectedTags.where((e) => e != tag).toList();
    } else {
      selectedTags = List<Tag>.from(state.selectedTags)..add(tag);
    }

    emit(state.copyWith(selectedTags: selectedTags));
  }

  void changeCategorySelection(Category category) {
    final List<Category> selectedCategories;
    if (state.selectedCategories.contains(category)) {
      selectedCategories =
          state.selectedCategories.where((e) => e != category).toList();
    } else {
      selectedCategories = List<Category>.from(state.selectedCategories)
        ..add(category);
    }

    emit(state.copyWith(selectedCategories: selectedCategories));
  }

  void changeIgnoreSelected(bool ignoreSelected) {
    emit(state.copyWith(ignoreSelected: ignoreSelected));
  }

  void _setChats(List<Chat> chats) {
    emit(state.copyWith(chats: chats));
  }

  void _setTags(List<Tag> tags) {
    emit(state.copyWith(tags: tags));
  }

  void _setCategories(List<Category> categories) {
    emit(state.copyWith(categories: categories));
  }
}
