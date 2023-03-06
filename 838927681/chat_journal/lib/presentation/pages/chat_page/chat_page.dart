import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hashtager/hashtager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/entities/icon_map.dart';
import '../../../theme/colors.dart';
import '../../widgets/search_delegate.dart';
import '../chat_page/chat_page_cubit.dart';
import '../chat_page/chat_page_state.dart';
import '../settings_page/settings_cubit.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;
  final _controller = TextEditingController();
  late final ChatCubit chatCubit;

  ChatPage({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    chatCubit = context.read<ChatCubit>();
    chatCubit.init(chat.id);
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(chat);
            return false;
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: state.isSelecting ? false : true,
                title: Text(
                  _appBarTitle(state, context),
                  style:
                      context.watch<SettingsCubit>().state.fontSize.headline3!,
                ),
                leading: !state.isSelecting
                    ? IconButton(
                        onPressed: () {
                          chatCubit.changeIsEditingToValue(value: false);
                          Navigator.of(context).pop(
                            chat,
                          );
                        },
                        icon: const Icon(Icons.arrow_back))
                    : IconButton(
                        onPressed: chatCubit.selectionToFalse,
                        icon: const Icon(Icons.close),
                      ),
                actions: _appBarActions(state, context),
              ),
              body: _chatBody(state, context),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _appBarActions(ChatState state, BuildContext context) {
    if (state.isSelecting) {
      return _eventActions(state, context);
    }
    if (state.isEditing) {
      return [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => chatCubit.changeIsEditingToValue(value: false),
        ),
      ];
    }
    return _chatActions(state, context);
  }

  String _appBarTitle(ChatState state, BuildContext context) {
    if (state.isSelecting) {
      return state.selectedCount.toString();
    }
    if (state.isEditing) {
      return 'Edit mode';
    }
    return chat.name;
  }

  List<Widget> _eventActions(ChatState state, BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () => _transferEvent(state, context),
      ),
      !state.isSelectedImage && state.selectedCount == 1
          ? IconButton(
              onPressed: () => _editEvent(state, context),
              icon: const Icon(Icons.edit),
            )
          : Container(),
      !state.isSelectedImage
          ? IconButton(
              onPressed: () => _copyEvent(state, context),
              icon: const Icon(Icons.copy),
            )
          : Container(),
      IconButton(
        onPressed: chatCubit.changeIsFavoriteEvent,
        icon: Icon(state.events[state.selectedIndex].isFavorite
            ? Icons.bookmark
            : Icons.bookmark_border_outlined),
      ),
      IconButton(
        onPressed: () => chatCubit.deleteEvents(state.selectedIndex),
        icon: const Icon(Icons.delete),
      ),
    ];
  }

  void _transferEvent(ChatState state, BuildContext context) async {
    final chats = await chatCubit.getChats();
    final result = await showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return _showChats(chats, state, context);
          },
        );
      },
    );
    if (result != null && chats[result].id != chat.id) {
      chatCubit.transferEvents(chats[result].id);
    }
  }

  Widget _showChats(List<Chat> chats, ChatState state, BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select the page you want to migrate the selected event(s) to!',
        style: context.watch<SettingsCubit>().state.fontSize.bodyText1!,
      ),
      content: Container(
        padding: const EdgeInsets.all(10),
        child: _radioChat(chats, state, context),
      ),
      actions: [
        TextButton(
          onPressed: () {
            chatCubit.selectionToFalse();
            Navigator.pop(context, null);
          },
          child: const Text('Cancel'),
        ),
        state.selectedRadioIndex != null
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context, state.selectedRadioIndex);
                },
                child: const Text('OK'),
              )
            : Container(),
      ],
    );
  }

  Widget _radioChat(List<Chat> chats, ChatState state, BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: ListView.builder(
        key: UniqueKey(),
        itemCount: chats.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              chats[i].name,
              style: context.watch<SettingsCubit>().state.fontSize.bodyText1!,
            ),
            leading: Radio<int>(
              groupValue: state.selectedRadioIndex,
              value: i,
              onChanged: chatCubit.changeRadioIndex,
            ),
          );
        },
      ),
    );
  }

  void _editEvent(ChatState state, BuildContext context) {
    if (state.events[state.selectedIndex].imagePath == '') {
      chatCubit.changeIsEditingToValue(value: true, index: state.selectedIndex);
      _controller.text = state.events[state.selectedIndex].text;
    }
  }

  void _copyEvent(ChatState state, BuildContext context) {
    var clipboardText = '';
    if (state.selectedCount == 1) {
      clipboardText = state.events[state.selectedIndex].text;
    } else {
      for (final event in state.events) {
        if (event.isSelected) {
          clipboardText += '${event.text} ';
        }
      }
    }
    Clipboard.setData(
      ClipboardData(
        text: clipboardText,
      ),
    );
    chatCubit.changeSelection();
  }

  List<Widget> _chatActions(ChatState state, BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: ChatJournalSearch(
              chatCubit: chatCubit,
              settingsCubit: BlocProvider.of<SettingsCubit>(context),
            ),
          );
        },
      ),
      IconButton(
        onPressed: chatCubit.changeFavoritesMode,
        icon: state.isFavoritesMode
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_border_outlined),
      ),
    ];
  }

  Widget _chatBody(ChatState state, BuildContext context) {
    final eventCount = state.events.length;
    return Container(
      decoration: context.watch<SettingsCubit>().state.backgroundImage != ''
          ? BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(context.watch<SettingsCubit>().state.backgroundImage),
                ),
              ),
            )
          : const BoxDecoration(),
      child: Column(
        children: [
          (eventCount != 0 && !state.isFavoritesMode) ||
                  (state.isFavoritesMode && state.favorites.isNotEmpty)
              ? Flexible(child: _chatWithEvents(state, context))
              : _chatWithNoEvents(state, context),
          eventCount != 0 ? Container() : Expanded(child: Container()),
          _conditionPanels(state, context),
          _inputPanel(state, context),
        ],
      ),
    );
  }

  Widget _conditionPanels(ChatState state, BuildContext context) {
    if (state.isSendingImage) {
      return _sendImageOptions(context);
    }
    if (state.isSelectingCategory) {
      return _selectCategory();
    }
    if (state.isAddingTag) {
      return _tagPanel(state, context);
    }
    return Container();
  }

  Widget _tagPanel(ChatState state, BuildContext context) {
    final tagList = state.tags
        .toList()
        .where(
          (element) =>
              element.contains(extractHashTags(state.currentInput).last),
        )
        .toList();
    if (tagList.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: ChatJournalColors.lightRed,
            borderRadius: BorderRadius.circular(15),
          ),
          child:
              Text('Adding Tag: ${extractHashTags(state.currentInput).last}'),
        ),
      );
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: 50),
      child: ListView.builder(
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemCount: tagList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: _tagItem(tagList[index], context),
          );
        },
      ),
    );
  }

  Widget _tagItem(String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        final index = _controller.text.lastIndexOf('#');
        _controller.text = '${_controller.text.substring(0, index)}$text ';
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ChatJournalColors.lightRed,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        child: HashTagText(
          text: text,
          decoratedStyle:
              context.watch<SettingsCubit>().state.fontSize.bodyText1!.copyWith(
                    color: Colors.blue,
                  ),
          basicStyle:
              context.watch<SettingsCubit>().state.fontSize.bodyText1!.copyWith(
                    color: context.read<SettingsCubit>().isLight()
                        ? Colors.black
                        : Colors.white,
                  ),
        ),
      ),
    );
  }

  Widget _selectCategory() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 90),
      child: ListView.builder(
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemCount: ChatJournalIcons.eventIcons.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: _categoryItem(index, context),
          );
        },
      ),
    );
  }

  Widget _categoryItem(int index, BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () => chatCubit.changeSelectedIcon(index),
            icon: Icon(
              ChatJournalIcons.eventIcons[index],
            ),
          ),
        ),
        Text(
          ChatJournalIcons.eventIconsName[index] ?? '',
          style: context.watch<SettingsCubit>().state.fontSize.bodyText1!,
        )
      ],
    );
  }

  Widget _sendImageOptions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _sendImageFromSource(false, context),
        ),
        Expanded(
          child: _sendImageFromSource(true, context),
        ),
      ],
    );
  }

  Widget _sendImageFromSource(bool isGallery, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final media = await ImagePicker().pickImage(
          source: isGallery ? ImageSource.gallery : ImageSource.camera,
        );
        if (media != null) {
          final imagePath = media.path;
          chatCubit.addEvent(
            Event(
              text: '',
              dateTime: DateTime.now(),
              imagePath: imagePath,
              parentId: chat.id,
              id: '',
            ),
          );
        }
      },
      child: Padding(
        padding: isGallery
            ? const EdgeInsets.fromLTRB(20, 15, 40, 15)
            : const EdgeInsets.fromLTRB(40, 15, 20, 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  isGallery ? Icons.image : Icons.camera_alt,
                  color: Colors.black,
                ),
              ),
              //const SizedBox(width: 15),
              Expanded(
                child: Text(
                  isGallery ? 'Open gallery' : 'Open camera',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _favoriteEvents(ChatState state, BuildContext context) {
    final eventCount = state.events.length;
    return ListView.builder(
      itemCount: eventCount,
      reverse: true,
      itemBuilder: (context, index) {
        return state.events[eventCount - 1 - index].isFavorite
            ? _event(eventCount - 1 - index, state.events, state, context)
            : Container();
      },
    );
  }

  Widget _chatWithEvents(ChatState state, BuildContext context) {
    return _allEvents(
        state, context, state.isFavoritesMode ? state.favorites : state.events);
  }

  Widget _allEvents(ChatState state, BuildContext context, List<Event> events) {
    final eventCount = events.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: eventCount,
            reverse: true,
            itemBuilder: (context, index) {
              return _event(eventCount - 1 - index, events, state, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _event(
      int index, List<Event> events, ChatState state, BuildContext context) {
    final eventColor = BlocProvider.of<SettingsCubit>(context).isLight()
        ? ChatJournalColors.lightGreen
        : ChatJournalColors.darkGrey;
    final selectedEventColor = BlocProvider.of<SettingsCubit>(context).isLight()
        ? ChatJournalColors.accentLightGreen
        : ChatJournalColors.lightGrey;
    return Align(
      alignment: Alignment.bottomRight,
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            dismissalDuration: const Duration(milliseconds: 30),
            onDismissed: () => chatCubit.deleteEvents(index),
          ),
          children: [
            SlidableAction(
              onPressed: (context) => chatCubit.deleteEvents(index),
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            dismissalDuration: const Duration(milliseconds: 30),
            confirmDismiss: () async {
              _controller.text = state.events[index].text;
              chatCubit.changeIsEditingToValue(value: true, index: index);
              return false;
            },
            closeOnCancel: true,
            onDismissed: () {},
          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                _controller.text = state.events[index].text;
                chatCubit.changeIsEditingToValue(value: true, index: index);
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.edit,
            ),
          ],
        ),
        child: GestureDetector(
          onLongPress: () => chatCubit.changeSelectedIndex(index),
          onTap: () => chatCubit.onTapEvent(index),
          child: Column(
            children: [
              _dateSeparator(index, events, context),
              Row(
                mainAxisAlignment:
                    context.watch<SettingsCubit>().state.bubbleAlignment
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: state.events[index].isSelected
                          ? selectedEventColor
                          : eventColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          context.watch<SettingsCubit>().state.bubbleAlignment
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        _typeEvent(index, events, state, context),
                        _eventDate(index, events, context),
                      ],
                    ),
                  ),
                  events[index].isFavorite
                      ? const Icon(Icons.bookmark)
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeEvent(
      int index, List<Event> events, ChatState state, BuildContext context) {
    if (events[index].imagePath != '') {
      return CachedNetworkImage(
        imageUrl: events[index].imagePath,
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        ),
      );
    }
    if (events[index].iconIndex != 0) {
      return _categoryEvent(events[index], context);
    }
    return _messageEvent(events[index], context);
  }

  Widget _categoryEvent(Event event, BuildContext context) {
    final iconIndex = event.iconIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                ChatJournalIcons.eventIcons[iconIndex],
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              HashTagText(
                text: ChatJournalIcons.eventIconsName[iconIndex] ?? '',
                basicStyle: context
                    .watch<SettingsCubit>()
                    .state
                    .fontSize
                    .bodyText1!
                    .copyWith(
                      color: context.read<SettingsCubit>().isLight()
                          ? Colors.black
                          : Colors.white,
                    ),
                decoratedStyle: context
                    .watch<SettingsCubit>()
                    .state
                    .fontSize
                    .bodyText1!
                    .copyWith(color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _messageEvent(event, context),
      ],
    );
  }

  Widget _dateSeparator(int index, List<Event> events, BuildContext context) {
    final bool isOneDay;
    if (index != 0) {
      isOneDay = _isOneDay(events[index].dateTime, events[index - 1].dateTime);
    } else {
      isOneDay = false;
    }
    if (!isOneDay) {
      final textDate = _getTextDate(events[index].dateTime);
      return Align(
        alignment: _dateAlignment(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: BlocProvider.of<SettingsCubit>(context).isLight()
                ? ChatJournalColors.lightRed
                : ChatJournalColors.lightGrey,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            textDate,
            style: context.watch<SettingsCubit>().state.fontSize.bodyText1!,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Alignment _dateAlignment(BuildContext context) {
    final state = context.watch<SettingsCubit>().state;
    if (state.centerDate) {
      return Alignment.center;
    }
    if (state.bubbleAlignment) {
      return Alignment.centerRight;
    }
    return Alignment.centerLeft;
  }

  bool _isOneDay(DateTime a, DateTime b) {
    if (a.day == b.day && a.month == b.month && a.year == b.year) {
      return true;
    } else {
      return false;
    }
  }

  String _getTextDate(DateTime date) {
    var otherDay = DateTime.now();
    final oneDay = const Duration(days: 1);
    final difference = otherDay.difference(date).inHours;
    if (difference < 24 && _isOneDay(otherDay, date)) {
      return 'Today';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 48 && _isOneDay(date, otherDay)) {
      return 'Yesterday';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 72 && _isOneDay(date, otherDay)) {
      return '2 days ago';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 96 && _isOneDay(date, otherDay)) {
      return '3 days ago';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 120 && _isOneDay(date, otherDay)) {
      return '4days ago';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 144 && _isOneDay(date, otherDay)) {
      return '5 days ago';
    }
    return DateFormat('MMM d, y').format(date);
  }

  Widget _messageEvent(Event event, BuildContext context) {
    return HashTagText(
      text: event.text,
      basicStyle:
          context.watch<SettingsCubit>().state.fontSize.bodyText1!.copyWith(
                color: context.read<SettingsCubit>().isLight()
                    ? Colors.black
                    : Colors.white,
              ),
      decoratedStyle: context
          .watch<SettingsCubit>()
          .state
          .fontSize
          .bodyText1!
          .copyWith(color: Colors.blue),
      textAlign: TextAlign.left,
    );
  }

  Widget _eventDate(int index, List<Event> events, BuildContext context) {
    return Text(
      DateFormat('h:mm a').format(events[index].dateTime),
      style: context.watch<SettingsCubit>().state.fontSize.bodyText1!.copyWith(
            color: Colors.grey,
          ),
      textAlign: TextAlign.left,
    );
  }

  Widget _chatWithNoEvents(ChatState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: BlocProvider.of<SettingsCubit>(context).isLight()
                ? ChatJournalColors.lightGreen
                : ChatJournalColors.lightGrey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                _chatWithNoEventsTitle(chat.name),
                style: context.watch<SettingsCubit>().state.fontSize.bodyText1!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                state.isFavoritesMode
                    ? _chatWithNoFavoritesText()
                    : _chatWithNoEventsText(chat.name),
                style: context.watch<SettingsCubit>().state.fontSize.bodyText1!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _chatWithNoEventsTitle(String title) =>
      'This is page where you can track everything about "$title"!';

  String _chatWithNoEventsText(String title) =>
      'Add your first event to "$title" page by entering some text box below '
      'and hitting the send button. Long tap the send button to align the event'
      ' in the opposite direction. Tap on the bookmark icon on the top right corner'
      'to show the bookmarked events only.';

  String _chatWithNoFavoritesText() =>
      'You don\'t seem to have any bookmarked events yet. '
      'You can bookmark an event by single tapping the event';

  Widget _inputPanel(ChatState state, BuildContext context) {
    final selectedIcon = state.selectedIcon;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              chatCubit.changeIsSelectingCategory(!state.isSelectingCategory);
            },
            icon: Icon(
              selectedIcon != 0
                  ? ChatJournalIcons.eventIcons[selectedIcon]
                  : Icons.category,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
          Expanded(child: _textField(context, state)),
          state.isTyping || _controller.text.isNotEmpty
              ? _sendButton(state, context)
              : _sendImage(state, context),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context, ChatState state) {
    return Focus(
      onFocusChange: chatCubit.changeIsTypingToValue,
      child: HashTagTextField(
        controller: _controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          fillColor: BlocProvider.of<SettingsCubit>(context).isLight()
              ? Colors.grey[200]
              : ChatJournalColors.lightGrey,
          filled: true,
        ),
        onChanged: chatCubit.changeCurrentInput,
        decoratedStyle: const TextStyle(color: Colors.blue),
        onDetectionTyped: (text) => chatCubit.changeAddingTag(true),
        onDetectionFinished: () => chatCubit.changeAddingTag(false),
      ),
    );
  }

  Widget _sendButton(ChatState state, BuildContext context) {
    return IconButton(
      icon: state.isEditing
          ? const Icon(
              Icons.done,
              color: Colors.grey,
            )
          : const Icon(
              Icons.send,
              color: Colors.grey,
            ),
      onPressed: () {
        state.isEditing
            ? _finishEditingEvent(context)
            : _addEvent(state, context);
      },
    );
  }

  void _addEvent(ChatState state, BuildContext context) {
    final selectedIcon = state.selectedIcon;
    if (_controller.text.isNotEmpty) {
      chatCubit.addEvent(
        Event(
          text: _controller.text,
          dateTime: DateTime.now(),
          iconIndex: selectedIcon != 0 ? selectedIcon : 0,
          id: '',
          parentId: chat.id,
        ),
      );
      _controller.clear();
    }
  }

  void _finishEditingEvent(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      chatCubit.changeText(_controller.text);
      _controller.clear();
    }
  }

  Widget _sendImage(ChatState state, BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.photo_camera,
        color: Colors.grey,
      ),
      onPressed: () =>
          chatCubit.changeIsSendingImageToValue(!state.isSendingImage),
    );
  }
}
