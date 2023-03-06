part of 'chat_cubit.dart';

class NullPropertyWrapper<T> {
  final T value;

  const NullPropertyWrapper(this.value);
}

class ChatState extends Equatable {
  final Chat chat;
  final int nextEventId;
  final bool isEditMode;
  final bool isFavoriteMode;
  final List<int> selectedEventsIds;
  final bool showCategories;
  final Category? selectedCategory;

  ChatState({
    required this.chat,
    this.nextEventId = 0,
    this.isEditMode = false,
    this.isFavoriteMode = false,
    this.selectedEventsIds = const [],
    this.showCategories = false,
    this.selectedCategory,
  });

  ChatState copyWith({
    Chat? chat,
    int? nextEventId,
    bool? isEditMode,
    bool? isFavoriteMode,
    List<int>? selectedEventsIds,
    bool? showCategories,
    NullPropertyWrapper<Category?>? selectedCategory,
  }) =>
      ChatState(
        chat: chat ?? this.chat,
        nextEventId: nextEventId ?? this.nextEventId,
        isEditMode: isEditMode ?? this.isEditMode,
        isFavoriteMode: isFavoriteMode ?? this.isFavoriteMode,
        selectedEventsIds: selectedEventsIds ?? this.selectedEventsIds,
        showCategories: showCategories ?? this.showCategories,
        selectedCategory: selectedCategory != null
            ? selectedCategory.value
            : this.selectedCategory,
      );

  @override
  List<Object?> get props => [
        chat,
        nextEventId,
        isEditMode,
        isFavoriteMode,
        selectedEventsIds,
        showCategories,
        selectedCategory
      ];
}
