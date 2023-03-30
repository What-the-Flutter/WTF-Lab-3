part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final String? chatId;
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
    NullWrapper<String?>? chatId,
    NullWrapper<Map<String, Uint8List>?>? images,
    List<Event>? events,
    List<String>? selectedEventsIds,
    List<Category>? categories,
    List<Tag>? tags,
    bool? isEditMode,
    bool? isFavoriteMode,
    bool? showTags,
    bool? showCategories,
    NullWrapper<String?>? selectedCategoryId,
    String? text,
  }) =>
      ChatState(
        chatId: chatId != null ? chatId.value : this.chatId,
        events: events ?? this.events,
        selectedEventsIds: selectedEventsIds ?? this.selectedEventsIds,
        categories: categories ?? this.categories,
        tags: tags ?? this.tags,
        isEditMode: isEditMode ?? this.isEditMode,
        isFavoriteMode: isFavoriteMode ?? this.isFavoriteMode,
        showTags: showTags ?? this.showTags,
        showCategories: showCategories ?? this.showCategories,
        text: text ?? this.text,
        images: images != null ? images.value : this.images,
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
