part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final String chatId;
  final EventsSubscription? eventsSubscription;
  final CategoriesSubscription? categoriesSubscription;
  final TagsSubscription? tagsSubscription;
  final Map<String, Uint8List>? images;

  final List<Event> events;
  final List<String> selectedEventsIds;
  final List<Category> categories;
  final List<Tag> tags;

  final bool isEditMode;
  final bool isFavoriteMode;
  final bool showTags;
  final bool showCategories;

  final String? selectedCategoryId;
  final String? text;

  const ChatState({
    required this.chatId,
    this.eventsSubscription,
    this.categoriesSubscription,
    this.tagsSubscription,
    this.images,
    this.events = const [],
    this.selectedEventsIds = const [],
    this.categories = const [],
    this.tags = const [],
    this.isEditMode = false,
    this.isFavoriteMode = false,
    this.showTags = false,
    this.showCategories = false,
    this.selectedCategoryId,
    this.text,
  });

  ChatState copyWith({
    String? chatId,
    _NullWrapper<EventsSubscription?>? eventsSubscription,
    _NullWrapper<CategoriesSubscription?>? categoriesSubscription,
    _NullWrapper<TagsSubscription?>? tagsSubscription,
    _NullWrapper<Map<String, Uint8List>?>? images,
    List<Event>? events,
    List<String>? selectedEventsIds,
    List<Category>? categories,
    List<Tag>? tags,
    bool? isEditMode,
    bool? isFavoriteMode,
    bool? showTags,
    bool? showCategories,
    _NullWrapper<String?>? selectedCategoryId,
    String? text,
  }) =>
      ChatState(
        chatId: chatId ?? this.chatId,
        events: events ?? this.events,
        selectedEventsIds: selectedEventsIds ?? this.selectedEventsIds,
        categories: categories ?? this.categories,
        tags: tags ?? this.tags,
        isEditMode: isEditMode ?? this.isEditMode,
        isFavoriteMode: isFavoriteMode ?? this.isFavoriteMode,
        showTags: showTags ?? this.showTags,
        showCategories: showCategories ?? this.showCategories,
        text: text ?? this.text,
        eventsSubscription: eventsSubscription != null
            ? eventsSubscription.value
            : this.eventsSubscription,
        categoriesSubscription: categoriesSubscription != null
            ? categoriesSubscription.value
            : this.categoriesSubscription,
        tagsSubscription: tagsSubscription != null
            ? tagsSubscription.value
            : this.tagsSubscription,
        images: images != null
            ? images.value
            : this.images,
        selectedCategoryId: selectedCategoryId != null
            ? selectedCategoryId.value
            : this.selectedCategoryId,
      );

  @override
  List<Object?> get props => [
        chatId,
        events,
        images,
        selectedEventsIds,
        categories,
        tags,
        isEditMode,
        isFavoriteMode,
        showTags,
        showCategories,
        selectedCategoryId,
        text,
      ];
}

class _NullWrapper<T> {
  final T value;

  const _NullWrapper(this.value);
}
