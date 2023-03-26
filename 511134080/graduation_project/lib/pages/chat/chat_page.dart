import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void _clearTextInput() {
    _textFieldController.clear();
  }

  Widget _createListViewItem(index, ChatState state) {
    final cards = state.events;

    final current = cards.elementAt(index);

    if (cards.length == 1 || index == cards.length - 1) {
      return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateCard(date: current.time),
              EventCard(
                cardModel: current,
                key: UniqueKey(),
              )
            ],
          );
        },
      );
    } else {
      final next = cards.elementAt(index + 1);
      if (DateFormat('dd-MM-yyyy').format(current.time) !=
          DateFormat('dd-MM-yyyy').format(next.time)) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DateCard(date: current.time),
                EventCard(
                  cardModel: current,
                  key: UniqueKey(),
                ),
              ],
            );
          },
        );
      }
      return EventCard(
        cardModel: current,
        key: UniqueKey(),
      );
    }
  }

  void _onEnterEvent(String title, ChatState state) {
    context.read<ChatCubit>().onEnterSubmitted(title);
    _focusNode.unfocus();
    _clearTextInput();
  }

  Widget _returnEvents(ChatState chatState) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Expanded(
          flex: 10,
          child: ListView.builder(
            itemCount: chatState.eventsLength,
            reverse: true,
            itemBuilder: (_, index) {
              return _createListViewItem(index, chatState);
            },
          ),
        );
      },
    );
  }

  Widget _returnHintMessage(Chat chat, ChatState state) {
    final messages = state.hintMessages;
    return Expanded(
      flex: 9,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColorDark.withAlpha(30),
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

  IconButton _createCloseButton() {
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

  IconButton _createEditButton(Chat chat) {
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

  IconButton _createReplyButton(state) {
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
      builder: (context) {
        return SimpleDialog(
          title: Text(
            state.chats.length > 1
                ? 'Choose the chat you want to relocate selected events:'
                : 'Error!',
            textAlign: TextAlign.center,
          ),
          children: state.chats.length > 1
              ? _createOptions(state, context)
              : [
                  const Text(
                    'There is only one chat. Create a new one to move your events!',
                    textAlign: TextAlign.center,
                  ),
                ],
        );
      },
    );
  }

  List<SimpleDialogOption> _createOptions(
    HomeState state,
    BuildContext context,
  ) {
    return [
      for (final chat in state.chats)
        if (chat.id != widget._chatId)
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              context.read<ChatCubit>().moveSelectedEvents(chat);
            },
            child: Text(chat.title),
          ),
    ];
  }

  IconButton _createCopyButton() {
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

  IconButton _createBookMarkButton() {
    return IconButton(
      icon: const Icon(
        Icons.bookmark_border_outlined,
      ),
      onPressed: () {
        context.read<ChatCubit>().manageFavouritesFromSelectionMode();
      },
    );
  }

  IconButton _createDeleteButton() {
    return IconButton(
      icon: const Icon(
        Icons.delete,
      ),
      onPressed: () {
        context.read<ChatCubit>().deleteSelectedEvents();
      },
    );
  }

  AppBar _createSelectionModeAppBar(
      Chat chat, HomeState state, ChatState chatState) {
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
      leading: _createCloseButton(),
      actions: [
        _createEditButton(chat),
        _createReplyButton(state),
        _createCopyButton(),
        _createBookMarkButton(),
        _createDeleteButton(),
      ],
    );
  }

  AppBar _createDefaultAppBar(Chat chat, ChatState chatState) {
    return AppBar(
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(
        chat.title,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Colors.white,
            ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context, context.read<ChatCubit>().state.chat);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchingPage(
                  cards: chatState.chatEvents,
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: chat.isShowingFavourites
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_border_outlined),
          onPressed: () {
            context.read<ChatCubit>().toggleFavourites();
          },
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  AppBar _createAppBar(
      BuildContext context, Chat chat, HomeState state, ChatState chatState) {
    final isSelectionMode = context.read<ChatCubit>().state.isSelectionMode;
    if (isSelectionMode) {
      return _createSelectionModeAppBar(chat, state, chatState);
    } else {
      return _createDefaultAppBar(chat, chatState);
    }
  }

  Widget _createCategoriesChoice() {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          itemCount: categoryIcons.length - 1,
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
                        categoryIcons[index + 1],
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
                    categoryTitle[index + 1],
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

  Widget _createBottomBar(ChatState state) {
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
                  ? _createCategoriesChoice()
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
                        categoryIcons[state.categoryIconIndex],
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    Expanded(
                      child: _createTextField(state),
                    ),
                    state.categoryIconIndex == 0 && state.isInputEmpty
                        ? IconButton(
                            onPressed: () {
                              context
                                  .read<ChatCubit>()
                                  .toggleShowingImageOptions();
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              context
                                  .read<ChatCubit>()
                                  .onEnterSubmitted(_textFieldController.text);
                              _focusNode.unfocus();
                              _clearTextInput();
                            },
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _createTextField(ChatState state) {
    return TextField(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
            ),
        controller: _textFieldController,
        focusNode: _focusNode,
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
        onTap: () {
          context.read<ChatCubit>().toggleChoosingCategory();
        },
        onChanged: (value) {
          context.read<ChatCubit>().inputChanged(value);
        });
  }

  Container _createCameraButton() {
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

  Container _createGalleryButton() {
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

  Widget _createImageOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createCameraButton(),
          _createGalleryButton(),
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
          appBar: _createAppBar(
              context, chat, context.read<HomeCubit>().state, chatState),
          body: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Container(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    shouldShowMessage
                        ? _returnHintMessage(chat, chatState)
                        : _returnEvents(chatState),
                    chatState.isChoosingImageOptions
                        ? _createImageOptions()
                        : Container(),
                    _createBottomBar(chatState),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
