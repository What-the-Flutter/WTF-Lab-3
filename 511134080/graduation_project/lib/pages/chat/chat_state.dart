part of 'chat_cubit.dart';

class ChatState {
  final Chat chat;
  final int categoryIconIndex;
  final bool isChoosingCategory;
  final bool isEditingMode;
  final bool isSelectionMode;
  final bool isInputEmpty;
  final bool isChoosingImageOptions;
  late final List<String> _hintMessages;
  final List<Event> chatEvents;

  ChatState({
    this.chat = const Chat(
      iconId: 0,
      title: '',
      id: '',
      date: null,
    ),
    this.categoryIconIndex = 0,
    this.isChoosingCategory = false,
    this.isEditingMode = false,
    this.isSelectionMode = false,
    this.isInputEmpty = true,
    this.isChoosingImageOptions = false,
    this.chatEvents = const [],
  }) {
    _hintMessages = [
      'This is the page where you can track everything about "${chat.title}"!\n',
      'You don\'t seem to have any bookmarked events yet. You can bookmark an event by single tapping the event',
      'This is the page where you can track everything about "${chat.title}"!\n',
      'Add your first event to "${chat.title}" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
    ];
  }

  List<Event> get events => chat.isShowingFavourites
      ? List<Event>.from(
          chatEvents.reversed.where((card) => card.isFavourite),
        )
      : List<Event>.from(chatEvents.reversed);

  int get eventsLength => chat.isShowingFavourites
      ? chatEvents.where((card) => card.isFavourite).length
      : chatEvents.length;

  List<String> get hintMessages => chat.isShowingFavourites
      ? [_hintMessages[0], _hintMessages[1]]
      : [_hintMessages[2], _hintMessages[3]];

  ChatState copyWith({
    Chat? newChat,
    int? newCategoryIconIndex,
    bool? choosingCategory,
    bool? editingMode,
    bool? selectionMode,
    bool? inputEmpty,
    bool? choosingImageOptions,
    List<Event>? newEvents,
  }) =>
      ChatState(
        chat: newChat ?? chat,
        categoryIconIndex: newCategoryIconIndex ?? categoryIconIndex,
        isChoosingCategory: choosingCategory ?? isChoosingCategory,
        isEditingMode: editingMode ?? isEditingMode,
        isSelectionMode: selectionMode ?? isSelectionMode,
        isInputEmpty: inputEmpty ?? isInputEmpty,
        isChoosingImageOptions: choosingImageOptions ?? isChoosingImageOptions,
        chatEvents: newEvents ?? chatEvents,
      );
}
