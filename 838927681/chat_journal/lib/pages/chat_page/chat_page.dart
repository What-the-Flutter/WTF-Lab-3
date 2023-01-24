import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../theme/colors.dart';
import '../../theme/fonts.dart';
import '../../theme/theme_cubit.dart';
import '../chat_page/chat_page_cubit.dart';
import '../chat_page/chat_page_state.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  final chatCubit = ChatCubit();
  final _controller = TextEditingController();

  ChatPage({required this.chat, super.key});

  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (context) => widget.chatCubit,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<ChatCubit, ChatState>(
            bloc: widget.chatCubit,
            builder: (context, state) {
              widget.chatCubit.loadEvents(widget.chat.events);
              return Scaffold(
                appBar: AppBar(
                  centerTitle: state.isSelecting ? false : true,
                  title: Text(
                    state.isSelecting
                        ? state.selectedCount.toString()
                        : widget.chat.name,
                    style: Fonts.chatPageTitle,
                  ),
                  leading: !state.isSelecting
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(widget.chat);
                          },
                          icon: const Icon(Icons.arrow_back))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              widget.chatCubit.selectionToFalse();
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                  actions: state.isSelecting
                      ? _eventActions(state)
                      : _appBarActions(state),
                ),
                body: _chatBody(),
              );
            }),
      ),
    );
  }

  List<Widget> _eventActions(ChatState state) {
    return [
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () {},
      ),
      !widget.chatCubit.state.isSelectedImage &&
              widget.chatCubit.state.selectedCount == 1
          ? IconButton(
              onPressed: _editEvent,
              icon: const Icon(Icons.edit),
            )
          : Container(),
      !widget.chatCubit.state.isSelectedImage
          ? IconButton(
              onPressed: _copyEvent,
              icon: const Icon(Icons.copy),
            )
          : Container(),
      IconButton(
        onPressed: _bookmarkEvent,
        icon: Icon(widget.chatCubit.state.events[state.selectedIndex].isFavorite
            ? Icons.bookmark
            : Icons.bookmark_border_outlined),
      ),
      IconButton(
        onPressed: _deleteEvent,
        icon: const Icon(Icons.delete),
      ),
    ];
  }

  void _editEvent() {
    setState(() {
      widget.chatCubit.changeSelection();
      widget.chatCubit.editingToValue(true);
      widget._controller.text = widget
          .chatCubit.state.events[widget.chatCubit.state.selectedIndex].text;
    });
  }

  void _copyEvent() {
    var clipboardText = '';
    if (widget.chatCubit.state.selectedCount == 1) {
      clipboardText = widget
          .chatCubit.state.events[widget.chatCubit.state.selectedIndex].text;
    } else {
      for (final event in widget.chatCubit.state.events) {
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
    setState(() {
      widget.chatCubit.changeSelection();
    });
  }

  void _bookmarkEvent() {
    setState(() {
      widget.chatCubit.changeIsFavoriteEvent();
      widget.chatCubit.selectionToFalse();
    });
  }

  void _deleteEvent() {
    setState(() {
      final isFavorite = widget.chatCubit.state
          .events[widget.chatCubit.state.selectedIndex].isFavorite;
      if (isFavorite) {
        widget.chatCubit.decrementFavoritesCount();
      }
      widget.chatCubit.deleteEvents();
    });
  }

  List<Widget> _appBarActions(ChatState state) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
      IconButton(
        onPressed: () {
          setState(() {
            widget.chatCubit.changeIsSendingImageToValue(false);
            widget.chatCubit.changeFavoritesMode();
          });
        },
        icon: state.isFavoritesMode
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_border_outlined),
      ),
    ];
  }

  Widget _chatBody() {
    final eventCount = widget.chatCubit.state.events.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (eventCount != 0 && !widget.chatCubit.state.isFavoritesMode) ||
                (widget.chatCubit.state.isFavoritesMode &&
                    widget.chatCubit.state.favoritesCount != 0)
            ? Flexible(child: _chatWithEvents())
            : _chatWithNoEvents(),
        eventCount != 0 ? Container() : Expanded(child: Container()),
        widget.chatCubit.state.isSendingImage
            ? _sendImageOptions()
            : Container(),
        _inputPanel(),
      ],
    );
  }

  Widget _sendImageOptions() {
    return Row(
      children: [
        Expanded(
          child: _sendImageFromSource(false),
        ),
        Expanded(
          child: _sendImageFromSource(true),
        ),
      ],
    );
  }

  Widget _sendImageFromSource(bool isGallery) {
    return GestureDetector(
      onTap: () async {
        final media = await ImagePicker().pickImage(
          source: isGallery ? ImageSource.gallery : ImageSource.camera,
        );
        if (media != null) {
          final imagePath = media.path;
          setState(() {
            widget.chatCubit.addEvent(Event(
                text: '', dateTime: DateTime.now(), imagePath: imagePath));
          });
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

  Widget _favoriteEvents() {
    final eventCount = widget.chatCubit.state.events.length;
    return ListView.builder(
      itemCount: eventCount,
      padding: EdgeInsets.zero,
      reverse: true,
      itemBuilder: (context, index) {
        return widget.chatCubit.state.events[eventCount - 1 - index].isFavorite
            ? _event(eventCount - 1 - index)
            : Container();
      },
    );
  }

  Widget _chatWithEvents() {
    return widget.chatCubit.state.isFavoritesMode
        ? _favoriteEvents()
        : _allEvents();
  }

  Widget _allEvents() {
    final eventCount = widget.chatCubit.state.events.length;
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: eventCount,
            padding: EdgeInsets.zero,
            reverse: true,
            itemBuilder: (context, index) {
              return _event(eventCount - 1 - index);
            },
          ),
        ),
      ],
    );
  }

  Widget _event(int index) {
    final eventColor = BlocProvider.of<ThemeCubit>(context).isLight()
        ? ChatJournalColors.lightGreen
        : ChatJournalColors.darkGray;
    final selectedEventColor = BlocProvider.of<ThemeCubit>(context).isLight()
        ? ChatJournalColors.accentLightGreen
        : ChatJournalColors.lightGray;
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            widget.chatCubit.changeSelectedIndex(index);
            widget.chatCubit.changeSelection();
          });
        },
        onTap: () {
          widget.chatCubit.changeSelectedIndex(index);
          if (!widget.chatCubit.state.isSelecting) {
            setState(() {
              widget.chatCubit.changeIsFavoriteEvent();
            });
          } else {
            setState(() {
              widget.chatCubit.changeSelectedItem(index);
            });
          }
        },
        child: Column(
          children: [
            _dateSeparator(index),
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
                    color: widget.chatCubit.state.events[index].isSelected
                        ? selectedEventColor
                        : eventColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.chatCubit.state.events[index].imagePath == ''
                          ? _messageEvent(index)
                          : Image.file(File(
                              widget.chatCubit.state.events[index].imagePath)),
                      _eventDate(index),
                    ],
                  ),
                ),
                widget.chatCubit.state.events[index].isFavorite
                    ? const Icon(Icons.bookmark)
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateSeparator(int index) {
    final bool isOneDay;
    if (index != 0) {
      isOneDay = _isOneDay(widget.chatCubit.state.events[index].dateTime,
          widget.chatCubit.state.events[index - 1].dateTime);
    } else {
      isOneDay = false;
    }
    if (!isOneDay) {
      final textDate =
          _getTextDate(widget.chatCubit.state.events[index].dateTime);
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
                : ChatJournalColors.lightGray,
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

  Widget _messageEvent(int index) {
    return Text(
      widget.chatCubit.state.events[index].text,
      style: Fonts.eventFont,
      textAlign: TextAlign.left,
    );
  }

  Widget _eventDate(int index) {
    return Text(
      DateFormat('h:mm a')
          .format(widget.chatCubit.state.events[index].dateTime),
      style: Fonts.eventDateFont,
      textAlign: TextAlign.left,
    );
  }

  Widget _chatWithNoEvents() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: BlocProvider.of<ThemeCubit>(context).isLight()
                ? ChatJournalColors.lightGreen
                : ChatJournalColors.lightGray,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                _chatWithNoEventsTitle(widget.chat.name),
                style: Fonts.chatWithNoEventsFont,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                widget.chatCubit.state.isFavoritesMode
                    ? _chatWithNoFavoritesText()
                    : _chatWithNoEventsText(widget.chat.name),
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

  Widget _inputPanel() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.pending,
              color: Colors.grey,
            ),
          ),
          Expanded(child: _textField()),
          widget.chatCubit.state.isTyping || widget._controller.text.isNotEmpty
              ? _sendButton()
              : _sendImage(),
        ],
      ),
    );
  }

  Widget _textField() {
    return Focus(
      onFocusChange: (value) {
        setState(
          () {
            widget.chatCubit.changeIsTypingToValue(value);
          },
        );
      },
      child: TextField(
        controller: widget._controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          fillColor: BlocProvider.of<ThemeCubit>(context).isLight()
              ? Colors.grey[200]
              : ChatJournalColors.lightGray,
          filled: true,
        ),
      ),
    );
  }

  Widget _sendButton() {
    return IconButton(
      icon: widget.chatCubit.state.isEditing
          ? const Icon(
              Icons.done,
              color: Colors.grey,
            )
          : const Icon(
              Icons.send,
              color: Colors.grey,
            ),
      onPressed: () {
        widget.chatCubit.state.isEditing ? _finishEditingEvent() : _addEvent();
      },
    );
  }

  void _addEvent() {
    if (widget._controller.text.isNotEmpty) {
      setState(() {
        widget.chatCubit.addEvent(
            Event(text: widget._controller.text, dateTime: DateTime.now()));
        widget.chatCubit.favoritesModeToFalse();
        widget._controller.clear();
      });
    }
  }

  void _finishEditingEvent() {
    if (widget._controller.text.isNotEmpty) {
      setState(() {
        widget.chatCubit.editingToValue(false);
        widget.chatCubit.state.events[widget.chatCubit.state.selectedIndex]
            .text = widget._controller.text;
        widget._controller.clear();
      });
    }
  }

  Widget _sendImage() {
    return IconButton(
      icon: const Icon(
        Icons.photo_camera,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          widget.chatCubit.changeIsSendingImageToValue(
              !widget.chatCubit.state.isSendingImage);
        });
      },
    );
  }
}
