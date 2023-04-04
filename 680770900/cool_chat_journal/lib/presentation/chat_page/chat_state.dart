part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final String? chatId;
  final Map<String, Uint8List>? images;
  final Event? editedEvent;

  final List<Event> events;
  final List<Event> selectedEvents;
  final List<Category> categories;
  final List<Tag> tags;

  final bool isFavoriteMode;
  final bool showTags;
  final bool showCategories;

  final String? selectedCategoryId;
  final String? text;

  const ChatState({
    required this.chatId,
    this.images,
    this.events = const [],
    this.selectedEvents = const [],
    this.categories = const [],
    this.tags = const [],
    this.editedEvent,
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
    List<Event>? selectedEvents,
    List<Category>? categories,
    List<Tag>? tags,
    NullWrapper<Event?>? editedEvent,
    bool? isFavoriteMode,
    bool? showTags,
    bool? showCategories,
    NullWrapper<String?>? selectedCategoryId,
    String? text,
  }) =>
      ChatState(
        chatId: chatId != null ? chatId.value : this.chatId,
        events: events ?? this.events,
        selectedEvents: selectedEvents ?? this.selectedEvents,
        categories: categories ?? this.categories,
        tags: tags ?? this.tags,
        isFavoriteMode: isFavoriteMode ?? this.isFavoriteMode,
        showTags: showTags ?? this.showTags,
        showCategories: showCategories ?? this.showCategories,
        text: text ?? this.text,
        images: images != null ? images.value : this.images,
        selectedCategoryId: selectedCategoryId != null
            ? selectedCategoryId.value
            : this.selectedCategoryId,
        editedEvent: editedEvent != null ? editedEvent.value : this.editedEvent,
      );

  @override
  List<Object?> get props => [
        chatId,
        events,
        images,
        selectedEvents,
        categories,
        tags,
        editedEvent,
        isFavoriteMode,
        showTags,
        showCategories,
        selectedCategoryId,
        text,
      ];
}
