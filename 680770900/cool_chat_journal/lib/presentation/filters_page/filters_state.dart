part of 'filters_cubit.dart';

class FiltersState extends Equatable {
  final List<Chat> chats;
  final List<Chat> selectedChats;

  final List<Tag> tags;
  final List<Tag> selectedTags;

  final List<Category> categories;
  final List<Category> selectedCategories;

  final bool ignoreSelected;

  const FiltersState({
    this.chats = const [],
    this.selectedChats = const [],
    this.tags = const [],
    this.selectedTags = const [],
    this.categories = const [],
    this.selectedCategories = const [],
    this.ignoreSelected = true,
  });

  FiltersState copyWith({
    List<Chat>? chats,
    List<Chat>? selectedChats,
    List<Tag>? tags,
    List<Tag>? selectedTags,
    List<Category>? categories,
    List<Category>? selectedCategories,
    bool? ignoreSelected,
  }) =>
      FiltersState(
          chats: chats ?? this.chats,
          selectedChats: selectedChats ?? this.selectedChats,
          tags: tags ?? this.tags,
          selectedTags: selectedTags ?? this.selectedTags,
          categories: categories ?? this.categories,
          selectedCategories: selectedCategories ?? this.selectedCategories,
          ignoreSelected: ignoreSelected ?? this.ignoreSelected);

  @override
  List<Object> get props => [
        chats,
        selectedChats,
        tags,
        selectedTags,
        categories,
        selectedCategories,
        ignoreSelected,
      ];
}
