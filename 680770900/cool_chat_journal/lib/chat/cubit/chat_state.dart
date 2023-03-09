part of 'chat_cubit.dart';

class NullPropertyWrapper<T> {
  final T value;

  const NullPropertyWrapper(this.value);
}

class ChatState extends Equatable {
  final Chat chat;
  final bool isEditMode;
  final bool isFavoriteMode;
  final List<String> selectedEventsIds;
  final bool showCategories;
  final Category? selectedCategory;

  const ChatState({
    required this.chat,
    this.isEditMode = false,
    this.isFavoriteMode = false,
    this.selectedEventsIds = const [],
    this.showCategories = false,
    this.selectedCategory,
  });

  ChatState copyWith({
    Chat? chat,
    bool? isEditMode,
    bool? isFavoriteMode,
    List<String>? selectedEventsIds,
    bool? showCategories,
    NullPropertyWrapper<Category?>? selectedCategory,
  }) =>
      ChatState(
        chat: chat ?? this.chat,
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
    isEditMode,
    isFavoriteMode,
    selectedEventsIds,
    showCategories,
    selectedCategory,
  ];
}
