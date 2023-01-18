import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/chat.dart';
import '../models/event.dart';
import '../theme/colors.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({required this.chat, super.key});

  @override
  State<ChatPage> createState() => ChatPageState(chat: chat);
}

class ChatPageState extends State<ChatPage> {
  final Chat chat;
  final _controller = TextEditingController();
  bool _isTyping = false;
  bool _isEditing = false;
  bool _isSelecting = false;
  bool _isFavoritesMode = false;
  bool _isSendingImage = false;
  int _selectedIndex = 0;
  final favorites = <Event>{};

  ChatPageState({required this.chat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _isSelecting ? '' : chat.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          leading: !_isSelecting
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _isSelecting = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
          actions: _isSelecting ? _eventActions() : _appBarActions(),
        ),
        body: _chatBody(chat, _isTyping, _controller),
      ),
    );
  }

  List<Widget> _eventActions() {
    return [
      IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () {},
      ),
      chat.events[_selectedIndex].image == null
          ? IconButton(
              onPressed: _editEvent,
              icon: const Icon(Icons.edit),
            )
          : Container(),
      chat.events[_selectedIndex].image == null
          ? IconButton(
              onPressed: _copyEvent,
              icon: const Icon(Icons.copy),
            )
          : Container(),
      IconButton(
        onPressed: _bookmarkEvent,
        icon: Icon(chat.events[_selectedIndex].isFavorite
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
      _isSelecting = !_isSelecting;
      _isEditing = true;
      _controller.text = chat.events[_selectedIndex].text;
    });
  }

  void _copyEvent() {
    Clipboard.setData(
      ClipboardData(
        text: chat.events[_selectedIndex].text,
      ),
    );
    setState(() {
      _isSelecting = !_isSelecting;
    });
  }

  void _bookmarkEvent() {
    setState(() {
      _isSelecting = false;
      addToOrRemoveFromFavorites(chat.events[_selectedIndex]);
    });
  }

  void _deleteEvent() {
    setState(() {
      _isSelecting = false;
      if (chat.events[_selectedIndex].isFavorite) {
        chat.favoritesCount--;
      }
      chat.events.removeAt(_selectedIndex);
    });
  }

  List<Widget> _appBarActions() {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
      IconButton(
        onPressed: () {
          setState(() {
            _isFavoritesMode = !_isFavoritesMode;
          });
        },
        icon: _isFavoritesMode
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_border_outlined),
      )
    ];
  }

  void addToOrRemoveFromFavorites(Event event) {
    if (event.isFavorite) {
      event.isFavorite = false;
      chat.favoritesCount--;
    } else {
      event.isFavorite = true;
      chat.favoritesCount++;
    }
  }
  Widget _chatBody(Chat chat, bool isTyping, TextEditingController controller) {
    final eventCount = chat.events.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (eventCount != 0 && !_isFavoritesMode) ||
                (_isFavoritesMode && chat.favoritesCount != 0)
            ? Flexible(child: _chatWithEvents())
            : _chatWithNoEvents(),
        eventCount != 0 ? Container() : Expanded(child: Container()),
        _isSendingImage ? _sendImageOptions() : Container(),
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
          final image = File(media.path);
          setState(() {
            chat.events.add(Event(
                text: '', dateTime: DateTime.now(), image: Image.file(image)));
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
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _favoriteEvents() {
    final eventCount = chat.events.length;
    return ListView.builder(
      itemCount: eventCount,
      padding: EdgeInsets.zero,
      reverse: true,
      itemBuilder: (context, index) {
        return chat.events[eventCount - 1 - index].isFavorite
            ? _event(eventCount - 1 - index)
            : Container();
      },
    );
  }

  Widget _chatWithEvents() {
    return _isFavoritesMode ? _favoriteEvents() : _allEvents();
  }

  Widget _allEvents() {
    final eventCount = chat.events.length;
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
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            _selectedIndex = index;
            _isSelecting = !_isSelecting;
          });
        },
        onTap: () {
          _selectedIndex = index;
          if (!_isSelecting) {
            setState(() {
              addToOrRemoveFromFavorites(chat.events[index]);
            });
          } else {
            setState(() {
              _isSelecting = false;
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
                    color: ChatJournalColors.eventColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      chat.events[index].image == null
                          ? _messageEvent(index)
                          : chat.events[index].image!,
                      _eventDate(index),
                    ],
                  ),
                ),
                chat.events[index].isFavorite
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
    if (index != 0 &&
        _isOneDay(
            chat.events[index].dateTime, chat.events[index - 1].dateTime)) {
      return Container();
    } else {
      final textDate = _getTextDate(chat.events[index].dateTime);
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Colors.redAccent,
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
      chat.events[index].text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _eventDate(int index) {
    return Text(
      DateFormat('h:mm a').format(chat.events[index].dateTime),
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
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
            color: ChatJournalColors.eventColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                _chatWithNoEventsTitle(chat.name),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                _isFavoritesMode
                    ? _chatWithNoFavoritesText()
                    : _chatWithNoEventsText(chat.name),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _chatWithNoEventsTitle(String title) {
    return 'This is page where you can track everything about "$title"!';
  }

  String _chatWithNoEventsText(String title) {
    return 'Add your first event to "$title" page by entering some text box below '
        'and hitting the send button. Long tap the send button to align the event'
        ' in the opposite direction. Tap on the bookmark icon on the top right corner'
        'to show the bookmarked events only.';
  }

  String _chatWithNoFavoritesText() {
    return 'You don\'t seem to have any bookmarked events yet. '
        'You can bookmark an event by single tapping the event';
  }

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
          Expanded(child: _textField(_controller)),
          _isTyping || _controller.text.isNotEmpty
              ? _sendButton()
              : _sendImage(),
        ],
      ),
    );
  }

  Widget _textField(TextEditingController controller) {
    return Focus(
      onFocusChange: (value) {
        setState(
          () {
            _isTyping = value;
          },
        );
      },
      child: TextField(
        controller: controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }

  Widget _sendButton() {
    return IconButton(
      icon: _isEditing
          ? const Icon(
              Icons.done,
              color: Colors.grey,
            )
          : const Icon(
              Icons.send,
              color: Colors.grey,
            ),
      onPressed: () {
        _isEditing ? _finishEditingEvent() : _addEvent();
      },
    );
  }

  void _addEvent() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        chat.events
            .add(Event(text: _controller.text, dateTime: DateTime.now()));
        _controller.clear();
      });
    }
  }

  void _finishEditingEvent() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _isEditing = false;
        chat.events[_selectedIndex].text = _controller.text;
        _controller.clear();
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
          _isSendingImage = !_isSendingImage;
        });
      },
    );
  }
}
