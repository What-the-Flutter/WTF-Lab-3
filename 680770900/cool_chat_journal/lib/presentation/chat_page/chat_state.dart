part of 'chat_cubit.dart';

enum ChatStatus { initial, loading, success, failure }

extension ChatStatusX on ChatStatus {
  bool get isInitial => this == ChatStatus.initial;
  bool get isLoading => this == ChatStatus.loading;
  bool get isSuccess => this == ChatStatus.success;
  bool get isFailure => this == ChatStatus.failure;
}

class NullPropertyWrapper<T> {
  final T value;

  const NullPropertyWrapper(this.value);
}

class ChatState extends Equatable {
  final String chatId;
  final List<Event> events;
  final bool isEditMode;
  final bool isFavoriteMode;
  final List<String> selectedEventsIds;
  final List<Category> categories;
  final bool showCategories;
  final String? selectedCategoryId;
  final ChatStatus status;

  const ChatState({
    required this.chatId,
    this.events = const [],
    this.isEditMode = false,
    this.isFavoriteMode = false,
    this.selectedEventsIds = const [],
    this.categories = const [],
    this.showCategories = false,
    this.selectedCategoryId,
    this.status = ChatStatus.initial,
  });

  ChatState copyWith({
    String? chatId,
    List<Event>? events,
    bool? isEditMode,
    bool? isFavoriteMode,
    List<String>? selectedEventsIds,
    List<Category>? categories,
    bool? showCategories,
    NullPropertyWrapper<String?>? selectedCategoryId,
    ChatStatus? status,
  }) =>
      ChatState(
        chatId: chatId ?? this.chatId,
        events: events ?? this.events,
        isEditMode: isEditMode ?? this.isEditMode,
        isFavoriteMode: isFavoriteMode ?? this.isFavoriteMode,
        selectedEventsIds: selectedEventsIds ?? this.selectedEventsIds,
        categories: categories ?? this.categories,
        showCategories: showCategories ?? this.showCategories,
        status: status ?? this.status,
        selectedCategoryId: selectedCategoryId != null
            ? selectedCategoryId.value
            : this.selectedCategoryId,
      );

  @override
  List<Object?> get props => [
        chatId,
        events,
        isEditMode,
        isFavoriteMode,
        selectedEventsIds,
        categories,
        showCategories,
        selectedCategoryId,
        status,
      ];
}
