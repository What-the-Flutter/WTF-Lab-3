import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../models/icon_map.dart';
import '../../theme/colors.dart';
import '../../theme/fonts.dart';
import '../../theme/theme_cubit.dart';
import '../../widgets/search_delegate.dart';
import '../chat_page/chat_page_cubit.dart';
import '../chat_page/chat_page_state.dart';
import '../home_page/home_page_cubit.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;
  final _controller = TextEditingController();

  ChatPage({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(chat.copyWith(events: state.events));
            return false;
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: state.isSelecting ? false : true,
                title: Text(
                  _appBarTitle(context),
                  style: Fonts.chatPageTitle,
                ),
                leading: !state.isSelecting
                    ? IconButton(
                        onPressed: () {
                          chatCubit.changeIsEditingToValue(false);
                          Navigator.of(context).pop(
                              chat.copyWith(events: chatCubit.state.events));
                        },
                        icon: const Icon(Icons.arrow_back))
                    : IconButton(
                        onPressed: chatCubit.selectionToFalse,
                        icon: const Icon(Icons.close),
                      ),
                actions: _appBarActions(context),
              ),
              body: _chatBody(context),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    if (chatCubit.state.isSelecting) {
      return _eventActions(context);
    }
    if (chatCubit.state.isEditing) {
      return [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            chatCubit.changeIsEditingToValue(false);
          },
        ),
      ];
    }
    return _chatActions(context);
  }

  String _appBarTitle(BuildContext context) {
    final state = BlocProvider.of<ChatCubit>(context).state;
    if (state.isSelecting) {
      return state.selectedCount.toString();
    }
    if (state.isEditing) {
      return 'Edit mode';
    }
    return chat.name;
  }

  List<Widget> _eventActions(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return [
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () {
          _transferEvent(context);
        },
      ),
      !chatCubit.state.isSelectedImage && chatCubit.state.selectedCount == 1
          ? IconButton(
              onPressed: () {
                chatCubit.selectionToFalse();
                _editEvent(context);
              },
              icon: const Icon(Icons.edit),
            )
          : Container(),
      !chatCubit.state.isSelectedImage
          ? IconButton(
              onPressed: () {
                _copyEvent(context);
              },
              icon: const Icon(Icons.copy),
            )
          : Container(),
      IconButton(
        onPressed: () {
          _bookmarkEvent(context);
        },
        icon: Icon(
            chatCubit.state.events[chatCubit.state.selectedIndex].isFavorite
                ? Icons.bookmark
                : Icons.bookmark_border_outlined),
      ),
      IconButton(
        onPressed: () {
          _deleteEvent(context);
        },
        icon: const Icon(Icons.delete),
      ),
    ];
  }

  void _transferEvent(BuildContext context) async {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final homeCubit = BlocProvider.of<HomePageCubit>(context);

    final result = await showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return _showChats(context);
          },
        );
      },
    );
    if (result != null && homeCubit.state.chats[result].id != chat.id) {
      if (chatCubit.state.selectedCount == 0) {
        final event = chatCubit.state.events[chatCubit.state.selectedIndex]
            .copyWith(isSelected: false);
        homeCubit.addEventToChat(result, event);
        chatCubit.deleteEvents();
      } else {
        var i = 0;
        while (i < chatCubit.state.events.length) {
          if (chatCubit.state.events[i].isSelected) {
            final event = chatCubit.state.events[i].copyWith(isSelected: false);
            homeCubit.addEventToChat(result, event);
            homeCubit.sortEvents(result);
          }
          i++;
        }
        chatCubit.deleteEvents();
      }
    }
    chatCubit.selectionToFalse();
    chatCubit.changeRadioIndex(0);
  }

  Widget _showChats(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return AlertDialog(
      title: Text(
        'Select the page you want to migrate the selected event(s) to!',
        style: Fonts.chatWithNoEventsFont,
      ),
      content: Container(
          padding: const EdgeInsets.all(10), child: _radioChat(context)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Text('Cancel'),
        ),
        chatCubit.state.selectedRadioIndex != null
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context, chatCubit.state.selectedRadioIndex);
                },
                child: const Text('OK'),
              )
            : Container(),
      ],
    );
  }

  Widget _radioChat(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final homeCubit = BlocProvider.of<HomePageCubit>(context);
    final chats = homeCubit.state.chats;
    return SizedBox(
      height: 200,
      width: 200,
      child: ListView.builder(
        itemCount: homeCubit.state.chats.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              chats[i].name,
              style: Fonts.eventFont,
            ),
            leading: Radio<int>(
              groupValue: chatCubit.state.selectedRadioIndex,
              value: i,
              onChanged: chatCubit.changeRadioIndex,
            ),
          );
        },
      ),
    );
  }

  void _editEvent(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    if (chatCubit.state.events[chatCubit.state.selectedIndex].imagePath == '') {
      chatCubit.changeSelection();
      chatCubit.editingToValue(true);
      _controller.text =
          chatCubit.state.events[chatCubit.state.selectedIndex].text;
      chatCubit.selectionToFalse();
    }
  }

  void _copyEvent(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    var clipboardText = '';
    if (chatCubit.state.selectedCount == 1) {
      clipboardText =
          chatCubit.state.events[chatCubit.state.selectedIndex].text;
    } else {
      for (final event in chatCubit.state.events) {
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

  void _bookmarkEvent(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    chatCubit.changeIsFavoriteEvent();
    chatCubit.selectionToFalse();
  }

  void _deleteEvent(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final isFavorite =
        chatCubit.state.events[chatCubit.state.selectedIndex].isFavorite;
    if (isFavorite) {
      chatCubit.decrementFavoritesCount(
        chatCubit.state.events[chatCubit.state.selectedIndex],
      );
    }
    chatCubit.deleteEvents();
  }

  List<Widget> _chatActions(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: ChatJournalSearch(
              chatCubit: chatCubit,
              themeCubit: BlocProvider.of<ThemeCubit>(context),
            ),
          );
        },
      ),
      IconButton(
        onPressed: () {
          chatCubit.changeIsSendingImageToValue(false);
          chatCubit.changeFavoritesMode();
        },
        icon: chatCubit.state.isFavoritesMode
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_border_outlined),
      ),
    ];
  }

  Widget _chatBody(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final eventCount = chatCubit.state.events.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (eventCount != 0 && !chatCubit.state.isFavoritesMode) ||
                (chatCubit.state.isFavoritesMode &&
                    chatCubit.state.favoritesCount != 0)
            ? Flexible(child: _chatWithEvents(context))
            : _chatWithNoEvents(context),
        eventCount != 0 ? Container() : Expanded(child: Container()),
        _conditionPanels(context),
        _inputPanel(context),
      ],
    );
  }

  Widget _conditionPanels(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    if (chatCubit.state.isSendingImage) {
      return _sendImageOptions(context);
    }
    if (chatCubit.state.isSelectingCategory) {
      return _selectCategory();
    }
    return Container();
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
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              chatCubit.changeSelectedIcon(index);
              chatCubit.changeIsSelectingCategory(false);
            },
            icon: Icon(
              ChatJournalIcons.eventIcons[index],
            ),
          ),
        ),
        Text(
          ChatJournalIcons.eventIconsName[index] ?? '',
          style: Fonts.eventFont,
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
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return GestureDetector(
      onTap: () async {
        final media = await ImagePicker().pickImage(
          source: isGallery ? ImageSource.gallery : ImageSource.camera,
        );
        if (media != null) {
          final imagePath = media.path;
          chatCubit.addEvent(
              Event(text: '', dateTime: DateTime.now(), imagePath: imagePath));
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

  Widget _favoriteEvents(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final eventCount = chatCubit.state.events.length;
    return ListView.builder(
      itemCount: eventCount,
      padding: EdgeInsets.zero,
      reverse: true,
      itemBuilder: (context, index) {
        return chatCubit.state.events[eventCount - 1 - index].isFavorite
            ? _event(eventCount - 1 - index, chatCubit.state.events, context)
            : Container();
      },
    );
  }

  Widget _chatWithEvents(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return _allEvents(
        context,
        chatCubit.state.isFavoritesMode
            ? chatCubit.state.favorites
            : chatCubit.state.events);
  }

  Widget _allEvents(BuildContext context, List<Event> events) {
    final eventCount = events.length;
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: eventCount,
            padding: EdgeInsets.zero,
            reverse: true,
            itemBuilder: (context, index) {
              return _event(eventCount - 1 - index, events, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _event(int index, List<Event> events, BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final eventColor = BlocProvider.of<ThemeCubit>(context).isLight()
        ? ChatJournalColors.lightGreen
        : ChatJournalColors.darkGrey;
    final selectedEventColor = BlocProvider.of<ThemeCubit>(context).isLight()
        ? ChatJournalColors.accentLightGreen
        : ChatJournalColors.lightGrey;
    return Align(
      alignment: Alignment.centerLeft,
      child: Dismissible(
        confirmDismiss: (direction) async {
          final isEditingImage = direction == DismissDirection.startToEnd &&
              chatCubit.state.events[index].imagePath != '';
          if (isEditingImage) {
            return false;
          }
          return true;
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            if (chatCubit.state.events[index].imagePath != '') {
              chatCubit.selectionToFalse();
            }
            chatCubit.changeSelectedIndex(index);
            _editEvent(context);
          } else if (direction == DismissDirection.endToStart) {
            chatCubit.changeSelectedIndex(index);
            _deleteEvent(context);
          }
        },
        key: ValueKey<Event>(chatCubit.state.events[index]),
        background: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.edit),
            const Icon(Icons.delete),
          ],
        ),
        child: GestureDetector(
          onLongPress: () {
            chatCubit.changeSelectedIndex(index);
            chatCubit.changeSelection();
          },
          onTap: () {
            chatCubit.changeSelectedIndex(index);
            if (!chatCubit.state.isSelecting) {
              chatCubit.changeIsFavoriteEvent();
            } else {
              chatCubit.changeSelectedItem(index);
            }
          },
          child: Column(
            children: [
              _dateSeparator(index, events, context),
              Row(
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
                      color: chatCubit.state.events[index].isSelected
                          ? selectedEventColor
                          : eventColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _typeEvent(index, events, context),
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

  Widget _typeEvent(int index, List<Event> events, BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    if (events[index].imagePath != '') {
      return Image.file(File(chatCubit.state.events[index].imagePath));
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
              Text(
                ChatJournalIcons.eventIconsName[iconIndex] ?? '',
                style: Fonts.eventFont,
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
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: BlocProvider.of<ThemeCubit>(context).isLight()
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
          child: Text(textDate),
        ),
      );
    } else {
      return Container();
    }
  }

  bool _isOneDay(DateTime a, DateTime b) {
    if (a.day == b.day && a.month == b.month && a.year == b.year) {
      return true;
    } else {
      return false;
    }
  }

  String _getTextDate(DateTime date) {
    final difference = DateTime.now().difference(date).inHours;
    if (difference < 24) {
      return 'Today';
    }
    if (difference < 48) {
      return 'Yesterday';
    }
    if (difference < 72) {
      return '2 days ago';
    }
    if (difference < 96) {
      return '3 days ago';
    }
    if (difference < 120) {
      return '4days ago';
    }
    if (difference < 144) {
      return '5 days ago';
    }
    return DateFormat('MMM d, y').format(date);
  }

  Widget _messageEvent(Event event, BuildContext context) {
    return Text(
      event.text,
      style: Fonts.eventFont,
      textAlign: TextAlign.left,
    );
  }

  Widget _eventDate(int index, List<Event> events, BuildContext context) {
    return Text(
      DateFormat('h:mm a').format(events[index].dateTime),
      style: Fonts.eventDateFont,
      textAlign: TextAlign.left,
    );
  }

  Widget _chatWithNoEvents(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: BlocProvider.of<ThemeCubit>(context).isLight()
                ? ChatJournalColors.lightGreen
                : ChatJournalColors.lightGrey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                _chatWithNoEventsTitle(chat.name),
                style: Fonts.chatWithNoEventsFont,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                chatCubit.state.isFavoritesMode
                    ? _chatWithNoFavoritesText()
                    : _chatWithNoEventsText(chat.name),
                style: Fonts.chatWithNoEventsFont,
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

  Widget _inputPanel(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final selectedIcon = chatCubit.state.selectedIcon;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              chatCubit.changeIsSelectingCategory(
                  !chatCubit.state.isSelectingCategory);
            },
            icon: Icon(
              selectedIcon != 0
                  ? ChatJournalIcons.eventIcons[selectedIcon]
                  : Icons.category,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
          Expanded(child: _textField(context)),
          chatCubit.state.isTyping || _controller.text.isNotEmpty
              ? _sendButton(context)
              : _sendImage(context),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Focus(
      onFocusChange: chatCubit.changeIsTypingToValue,
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          fillColor: BlocProvider.of<ThemeCubit>(context).isLight()
              ? Colors.grey[200]
              : ChatJournalColors.lightGrey,
          filled: true,
        ),
      ),
    );
  }

  Widget _sendButton(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return IconButton(
      icon: chatCubit.state.isEditing
          ? const Icon(
              Icons.done,
              color: Colors.grey,
            )
          : const Icon(
              Icons.send,
              color: Colors.grey,
            ),
      onPressed: () {
        chatCubit.state.isEditing
            ? _finishEditingEvent(context)
            : _addEvent(context);
      },
    );
  }

  void _addEvent(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final selectedIcon = chatCubit.state.selectedIcon;
    if (_controller.text.isNotEmpty) {
      chatCubit.addEvent(
        Event(
          text: _controller.text,
          dateTime: DateTime.now(),
          iconIndex: selectedIcon != 0 ? selectedIcon : 0,
        ),
      );
      chatCubit.favoritesModeToFalse();
      chatCubit.changeSelectedIcon(0);
      _controller.clear();
    }
  }

  void _finishEditingEvent(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    if (_controller.text.isNotEmpty) {
      chatCubit.editingToValue(false);
      chatCubit.changeText(_controller.text);
      _controller.clear();
    }
  }

  Widget _sendImage(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.photo_camera,
        color: Colors.grey,
      ),
      onPressed: () {
        final chatCubit = BlocProvider.of<ChatCubit>(context);
        chatCubit.changeIsSendingImageToValue(!chatCubit.state.isSendingImage);
      },
    );
  }
}
