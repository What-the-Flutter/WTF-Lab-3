import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/functions.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/chat.dart';
import '../../models/event.dart';
import '../../widgets/date_card.dart';
import '../../widgets/event_card.dart';
import '../home/home_cubit.dart';
import '../searching_page/searching_page.dart';
import '../settings/settings_cubit.dart';
import 'chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final String _chatId;

  const ChatPage({
    super.key,
    required String chatId,
  }) : _chatId = chatId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textFieldController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final chat = context
        .read<HomeCubit>()
        .state
        .chats
        .where((Chat chatModel) => chatModel.id == widget._chatId)
        .first;

    context.read<ChatCubit>().init(chat);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textFieldController.dispose();
    super.dispose();
  }

  void _clearTextInput() => _textFieldController.clear();

  Widget _listViewItem(index, ChatState state) {
    final cards = state.events;

    final current = cards.elementAt(index);

    if (cards.length == 1 || index == cards.length - 1) {
      return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateCard(date: current.time),
            EventCard(
              event: current,
              onTap: () {
                context.read<ChatCubit>().manageTapEvent(current);
              },
              onLongPress: () {
                context.read<ChatCubit>().manageLongPress(current);
              },
              key: UniqueKey(),
            )
          ],
        ),
      );
    } else {
      final next = cards.elementAt(index + 1);
      if (DateFormat('dd-MM-yyyy').format(current.time) !=
          DateFormat('dd-MM-yyyy').format(next.time)) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateCard(date: current.time),
              EventCard(
                event: current,
                onTap: () {
                  context.read<ChatCubit>().manageTapEvent(current);
                },
                onLongPress: () {
                  context.read<ChatCubit>().manageLongPress(current);
                },
                key: UniqueKey(),
              ),
            ],
          ),
        );
      }
      return EventCard(
        event: current,
        onTap: () {
          context.read<ChatCubit>().manageTapEvent(current);
        },
        onLongPress: () {
          context.read<ChatCubit>().manageLongPress(current);
        },
        key: UniqueKey(),
      );
    }
  }

  void _onEnterEvent(String title, ChatState state) {
    context.read<ChatCubit>().onEnterSubmitted(title);
    _focusNode.unfocus();
    _clearTextInput();
  }

  Widget _events(ChatState chatState) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        itemCount: chatState.eventsLength,
        reverse: true,
        itemBuilder: (_, index) => _listViewItem(index, chatState),
      ),
    );
  }

  Widget _hintMessage(Chat chat, ChatState state) {
    final messages = state.hintMessages;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: Column(
          children: [
            Text(
              messages[0],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
            ),
            Text(
              messages[1],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
            )
          ],
        ),
      ),
    );
  }

  IconButton _closeButton() {
    return IconButton(
      icon: const Icon(
        Icons.close,
      ),
      onPressed: () {
        context.read<ChatCubit>().cancelSelectionMode();
        context.read<ChatCubit>().toggleEditingMode();
        _textFieldController.text = '';
        context.read<ChatCubit>().changeCategoryIcon(0);
        _focusNode.unfocus();
      },
    );
  }

  IconButton _editButton(Chat chat) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
      ),
      onPressed: context
          .read<ChatCubit>()
          .onEditButtonPressed(_textFieldController, _focusNode),
      disabledColor: Theme.of(context).primaryColor,
    );
  }

  IconButton _replyButton(state) {
    return IconButton(
      icon: const Icon(
        Icons.reply,
      ),
      onPressed: () {
        _onReplyChosen(state);
      },
    );
  }

  Future _onReplyChosen(HomeState state) async {
    return await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          state.chats.length > 1
              ? 'Choose the chat you want to relocate selected events:'
              : 'Error!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
        ),
        children: state.chats.length > 1
            ? _options(state, context)
            : [
                const Text(
                  'There is only one chat. Create a new one to move your events!',
                  textAlign: TextAlign.center,
                ),
              ],
      ),
    );
  }

  List<SimpleDialogOption> _options(HomeState state, BuildContext context) {
    return [
      for (final chat in state.chats)
        if (chat.id != widget._chatId)
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              context.read<ChatCubit>().moveSelectedEvents(chat);
            },
            child: Text(
              chat.title,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
            ),
          ),
    ];
  }

  IconButton _copyButton() {
    return IconButton(
      icon: const Icon(
        Icons.copy,
      ),
      onPressed: () {
        context.read<ChatCubit>().copySelectedEvents();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Copied to the clipboard!',
            ),
          ),
        );
      },
    );
  }

  IconButton _bookMarkButton() {
    return IconButton(
      icon: const Icon(
        Icons.bookmark_border_outlined,
      ),
      onPressed: () {
        context.read<ChatCubit>().manageFavouritesFromSelectionMode();
      },
    );
  }

  IconButton _deleteButton() {
    return IconButton(
      icon: const Icon(
        Icons.delete,
      ),
      onPressed: () {
        context.read<ChatCubit>().deleteSelectedEvents();
      },
    );
  }

  AppBar _selectionModeAppBar(Chat chat, HomeState state, ChatState chatState) {
    final length = chatState.chatEvents
        .where((Event cardModel) => cardModel.isSelected)
        .length;

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        '$length',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      leading: _closeButton(),
      actions: [
        _editButton(chat),
        _replyButton(state),
        _copyButton(),
        _bookMarkButton(),
        _deleteButton(),
      ],
    );
  }

  Widget _leadingDefaultAppBar() {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        Navigator.pop(context, context.read<ChatCubit>().state.chat);
      },
    );
  }

  Widget _searchIconButton(ChatState chatState, Chat chat) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchingPage(
              cards: chatState.chatEvents,
              chatTitle: '\'${chat.title}\'',
              tags: chatState.tags,
              context: context,
            ),
          ),
        );
      },
    );
  }

  Widget _bookmarkIconButton(Chat chat) {
    return IconButton(
      icon: chat.isShowingFavourites
          ? const Icon(Icons.bookmark)
          : const Icon(Icons.bookmark_border_outlined),
      onPressed: context.read<ChatCubit>().toggleFavourites,
    );
  }

  AppBar _defaultAppBar(Chat chat, ChatState chatState) {
    return AppBar(
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        chat.title,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.white,
            ),
      ),
      leading: _leadingDefaultAppBar(),
      actions: [
        _searchIconButton(chatState, chat),
        _bookmarkIconButton(chat),
      ],
    );
  }

  AppBar _appBar(
      BuildContext context, Chat chat, HomeState state, ChatState chatState) {
    final isSelectionMode = context.read<ChatCubit>().state.isSelectionMode;
    if (isSelectionMode) {
      return _selectionModeAppBar(chat, state, chatState);
    } else {
      return _defaultAppBar(chat, chatState);
    }
  }

  Widget _categoriesChoice() {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          itemCount: allCategoryIcons.length - 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(96)),
                        color: index == 0
                            ? Theme.of(context).canvasColor
                            : Theme.of(context).hoverColor,
                      ),
                      child: Icon(
                        allCategoryIcons[index + 1],
                        size: 32,
                        color: index == 0 ? Colors.red : Colors.white,
                      ),
                    ),
                    onTap: () {
                      context.read<ChatCubit>().changeCategoryIcon(index + 1);
                      context.read<ChatCubit>().toggleChoosingCategory();
                    },
                  ),
                  Text(
                    allCategoryTitles[index + 1],
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _existingTagPanel(Iterable<String> existingTags, String inputtingTag) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          itemCount: existingTags.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Theme.of(context).highlightColor,
                      ),
                      child: Text(
                        existingTags.elementAt(index),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ),
                    onTap: () {
                      context.read<ChatCubit>().onExistingTagTap(
                            inputtingTag: inputtingTag,
                            existingTag: existingTags.elementAt(index),
                            inputController: _textFieldController,
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _newTagPanel(String inputtingTag) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).highlightColor,
            ),
            child: Text(
              'Adding Tag: $inputtingTag',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addingTagPanel(ChatState state) {
    final inputtingTag = extractHashTags(_textFieldController.text).last;
    if (state.tags.isNotEmpty) {
      final existingTags =
          state.tags.where((String tag) => tag.contains(inputtingTag));
      if (existingTags.isNotEmpty) {
        return _existingTagPanel(existingTags, inputtingTag);
      }
    }
    return _newTagPanel(inputtingTag);
  }

  Widget _cameraButtonBottomBar() {
    return IconButton(
      onPressed: () {
        context.read<ChatCubit>().toggleShowingImageOptions();
      },
      icon: Icon(
        Icons.camera_alt_rounded,
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _sendButton() {
    return IconButton(
      onPressed: () {
        context.read<ChatCubit>().onEnterSubmitted(_textFieldController.text);
        _focusNode.unfocus();
        _clearTextInput();
      },
      icon: Icon(
        Icons.send,
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _bottomBar(ChatState state) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              state.isChoosingCategory
                  ? _categoriesChoice()
                  : state.isAddingTag
                      ? _addingTagPanel(state)
                      : Container(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<ChatCubit>().toggleChoosingCategory(
                              choosingCategory: !state.isChoosingCategory,
                            );
                      },
                      icon: Icon(
                        allCategoryIcons[state.categoryIconIndex],
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    Expanded(
                      child: _textField(state),
                    ),
                    state.categoryIconIndex == 0 && state.isInputEmpty
                        ? _cameraButtonBottomBar()
                        : _sendButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(ChatState state) {
    return HashTagTextField(
      controller: _textFieldController,
      focusNode: _focusNode,
      decoratedStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
      basicStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
          ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Enter event',
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
            ),
        filled: true,
        fillColor: Theme.of(context).disabledColor.withAlpha(24),
      ),
      onSubmitted: (value) {
        _onEnterEvent(value, state);
      },
      onChanged: (value) {
        context.read<ChatCubit>().inputChanged(value);
      },
      onDetectionTyped: (_) {
        context.read<ChatCubit>().toggleAddingTagMode(true);
      },
      onDetectionFinished: () {
        context.read<ChatCubit>().toggleAddingTagMode(false);
      },
    );
  }

  Container _cameraButton() {
    return Container(
      width: 160,
      height: 64,
      decoration: BoxDecoration(
          color: Colors.red[100], borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: const Icon(
          Icons.camera_enhance,
          color: Colors.black,
        ),
        title: Text(
          'Open Camera',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.normal,
              ),
        ),
        onTap: () {
          context.read<ChatCubit>().pickImage(false);
        },
      ),
    );
  }

  Container _galleryButton() {
    return Container(
      width: 160,
      height: 64,
      decoration: BoxDecoration(
          color: Colors.red[100], borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: const Icon(
          Icons.photo,
          color: Colors.black,
        ),
        title: Text(
          'Open Gallery',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.normal,
              ),
        ),
        onTap: () {
          context.read<ChatCubit>().pickImage(true);
        },
      ),
    );
  }

  Widget _imageOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _cameraButton(),
          _galleryButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, chatState) {
        final chat = chatState.chat;
        final favourites =
            chatState.chatEvents.where((Event e) => e.isFavourite);

        final shouldShowMessage = chatState.chatEvents.isEmpty ||
            chat.isShowingFavourites && favourites.isEmpty;

        return Scaffold(
          appBar: _appBar(
              context, chat, context.read<HomeCubit>().state, chatState),
          body: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) => Container(
              decoration: state.backgroundImage != ''
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(
                          File(
                            state.backgroundImage,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  shouldShowMessage
                      ? _hintMessage(chat, chatState)
                      : _events(chatState),
                  chatState.isChoosingImageOptions
                      ? _imageOptions()
                      : Container(),
                  _bottomBar(chatState),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
