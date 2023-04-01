import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import '../../data/repository/repository.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  StreamSubscription<List<Chat>>? _chatsSubscription;
  StreamSubscription<List<Tag>>? _tagsSubscription;
  StreamSubscription<List<Category>>? _categoriesSubscription;

  final ChatsRepository chatsRepository;
  final TagsRepository tagsRepository;
  final CategoriesRepository categoriesRepository;

  FiltersCubit({
    required this.chatsRepository,
    required this.tagsRepository,
    required this.categoriesRepository,
  }) : super(const FiltersState());

  void subscribeFiltersStreams() {
    _chatsSubscription =
        chatsRepository.chatsStream.listen(_setChats);

    _tagsSubscription =
        tagsRepository.tagsStream.listen(_setTags);

    _categoriesSubscription =
        categoriesRepository.categoriesStream.listen(_setCategories);      
  }

  void unsubscribeFiltersStreams() {
    _chatsSubscription?.cancel(); 
    _tagsSubscription?.cancel(); 
    _categoriesSubscription?.cancel(); 
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
      selectedCategories = 
          List<Category>.from(state.selectedCategories)..add(category);
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
