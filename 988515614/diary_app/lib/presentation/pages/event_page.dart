import 'dart:io';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:diary_app/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  final String title;
  const EventPage({
    super.key,
    required this.title,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final _events = [
    Event(
      isMessage: false,
      dateTime: DateTime.now(),
      message: 'Today',
    )..isFavorite = true,
    Event(
      isMessage: true,
      dateTime: DateTime.now(),
      message:
          'Event 1 ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
    ),
    Event(
      isMessage: true,
      dateTime: DateTime.now(),
      message: 'Event 2',
    ),
    Event(
      isMessage: true,
      dateTime: DateTime.now(),
      message: 'Event 3',
    ),
  ]; // Mocked data

  final _controller = TextEditingController();
  var _isEditing = false;
  var _isSelectionMode = false;
  var _isMessageEditMode = false;
  var _isBookmarkMode = false;
  var _messageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(context),
        body: _body(),
      ),
    );
  } // Mocked data

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: _isSelectionMode
          ? IconButton(
              splashRadius: 20,
              icon: const Icon(CarbonIcons.close),
              onPressed: () {
                _turnOffSelectionMode();
              },
            )
          : IconButton(
              splashRadius: 20,
              icon: const Icon(CarbonIcons.arrow_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: _appbarActions(),
    );
  }

  List<Widget> _appbarActions() =>
      _isSelectionMode ? _selectionModeActions() : _defaultModeActions();

  List<Widget> _selectionModeActions() {
    return [
      IconButton(
        splashRadius: 20,
        icon: const Icon(CarbonIcons.delete),
        onPressed: () {
          setState(() {
            _events.removeWhere((element) => element.isSelected);
          });
          _turnOffSelectionMode();
        },
      ),
      IconButton(
        splashRadius: 20,
        icon: _isBookmarkMode
            ? const Icon(CarbonIcons.favorite_half)
            : const Icon(CarbonIcons.favorite),
        onPressed: () {
          setState(() {
            if (_isBookmarkMode) {
              for (var e in _events) {
                if (e.isSelected) {
                  e.isFavorite = false;
                }
              }
            } else {
              for (var e in _events) {
                if (e.isSelected) {
                  e.isFavorite = true;
                }
              }
            }
          });
          _turnOffSelectionMode();
        },
      ),
    ];
  }

  List<Widget> _defaultModeActions() {
    return [
      IconButton(
        splashRadius: 20,
        icon: const Icon(CarbonIcons.search),
        onPressed: () {},
      ),
      IconButton(
        splashRadius: 20,
        icon: _isBookmarkMode
            ? const Icon(CarbonIcons.bookmark_filled)
            : const Icon(CarbonIcons.bookmark),
        onPressed: () => setState(() {
          _isBookmarkMode = !_isBookmarkMode;
        }),
      ),
    ];
  }

  void _turnOffSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      for (var e in _events) {
        e.isSelected = false;
      }
    });
  }

  Widget _body() {
    return Column(
      children: [
        Flexible(
          child: _eventsList(),
        ),
        _messagePanel(),
      ],
    );
  }

  Widget _textField() {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          _isEditing = value;
        });
      },
      child: TextField(
        controller: _controller,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade200,
        ),
      ),
    );
  }

  Widget _messagePanel() {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(
              CarbonIcons.microphone,
              size: 30,
            ),
            onPressed: () {},
            color: Colors.teal,
          ),
          Expanded(
            child: _textField(),
          ),
          _isEditing
              ? _sendButtonVariants()
              : IconButton(
                  splashRadius: 20,
                  icon: const Icon(
                    CarbonIcons.camera,
                    size: 30,
                  ),
                  color: Colors.teal,
                  onPressed: () {
                    _showImageDialog();
                  },
                ),
        ],
      ),
    );
  }

  Widget _sendButtonVariants() =>
      _isMessageEditMode ? _editButton() : _sendButton();

  Widget _editButton() {
    return IconButton(
      splashRadius: 20,
      icon: const Icon(
        CarbonIcons.change_catalog,
        size: 30,
      ),
      color: Colors.teal,
      onPressed: () {
        if (_controller.text.isEmpty) return;
        setState(() {
          _events[_messageIndex] = Event(
            isMessage: true,
            dateTime: DateTime.now(),
            message: _controller.text.toString(),
          );
        });
        _controller.clear();
        setState(() {
          _isMessageEditMode = false;
          _messageIndex = 0;
        });
      },
    );
  }

  Widget _sendButton() {
    return IconButton(
      splashRadius: 20,
      icon: const Icon(
        CarbonIcons.send,
        size: 30,
      ),
      color: Colors.teal,
      onPressed: () {
        if (_controller.text.isEmpty) return;
        setState(() {
          _events.add(
            Event(
              isMessage: true,
              dateTime: DateTime.now(),
              message: _controller.text.toString(),
            ),
          );
        });
        _controller.clear();
      },
    );
  }

  void _showImageDialog() {
    final dialog = _imageDialog();

    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }

  Widget _imageDialog() {
    return AlertDialog(
      title: const Text('Choose image from'),
      actions: [
        TextButton(
          child: Row(
            children: const [
              Icon(
                CarbonIcons.camera,
                size: 30,
              ),
              Text('Camera'),
            ],
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.camera,
            );
            _createEventWithPicture(pickedFile);
          },
        ),
        TextButton(
          child: Row(
            children: const [
              Icon(
                CarbonIcons.drop_photo,
                size: 30,
              ),
              Text('Galery'),
            ],
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            _createEventWithPicture(pickedFile);
          },
        ),
      ],
    );
  }

  void _createEventWithPicture(XFile? pickedFile) {
    if (pickedFile != null) {
      setState(() {
        _events.add(
          Event(
            isMessage: true,
            dateTime: DateTime.now(),
            message: "",
            image: Image.file(
              File(pickedFile.path),
            ),
          ),
        );
      });
    }
  }

  Widget _eventsList() => _events.isEmpty ? _intro() : _eventsViews();

  Widget _intro() {
    return Center(
      child: Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lime.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This is the page where You can track'
                '\neverything about "Travel"!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Add first event to "Travel" page by\n'
                'entering the text in the text box below\n'
                'and tapping send button',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _eventsViews() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _isBookmarkMode ? _bookmarkedEvents() : _allEvents(),
      ],
    );
  }

  Widget _bookmarkedEvents() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        reverse: true,
        shrinkWrap: true,
        itemCount: _events.length,
        itemBuilder: (context, index) {
          // Display events in reverse order
          return _events[_events.length - 1 - index].isFavorite
              ? _eventListItem(
                  _events[_events.length - 1 - index],
                  _events.length - 1 - index,
                )
              : Container();
        },
      ),
    );
  }

  Widget _allEvents() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        reverse: true,
        shrinkWrap: true,
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return _eventListItem(
            _events[_events.length - 1 - index],
            _events.length - 1 - index,
          );
        },
      ),
    );
  }

  Widget _eventListItem(Event event, int eventIndex) {
    final timeMark = DateFormat('hh:mm a').format(event.dateTime);

    if (event.isMessage) {
      return event.image == null
          ? _messageEvent(event, eventIndex, timeMark)
          : _pictureEvent(event, eventIndex, timeMark);
    } else {
      return _timeEvent(event);
    }
  }

  Widget _timeEvent(Event event) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        margin: const EdgeInsets.only(left: 5, bottom: 7),
        decoration: BoxDecoration(
          color: Colors.deepOrange.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.message,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pictureEvent(Event event, int eventIndex, String timeMark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            if (!_isSelectionMode) {
              _isSelectionMode = true;
              _events[eventIndex].isSelected = !_events[eventIndex].isSelected;
            }
          });
        },
        onTap: () async {
          if (_isSelectionMode) {
            setState(() {
              _events[eventIndex].isSelected = !_events[eventIndex].isSelected;
            });
          }
        },
        child: _pictureEventContent(event, timeMark),
      ),
    );
  }

  Widget _pictureEventContent(Event event, String timeMark) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 350,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      margin: const EdgeInsets.only(left: 5, bottom: 7),
      decoration: BoxDecoration(
        color: event.isSelected ? Colors.amber : Colors.lime.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(
              minWidth: 100,
              minHeight: 200,
              maxWidth: 300,
              maxHeight: 200,
            ),
            child: event.image,
          ),
          const SizedBox(height: 3),
          Text(
            timeMark,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageEvent(Event event, int eventIndex, String timeMark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            if (!_isSelectionMode) {
              _isSelectionMode = true;
              _events[eventIndex].isSelected = !_events[eventIndex].isSelected;
            }
          });
        },
        onTap: () async {
          if (_isSelectionMode) {
            setState(() {
              _events[eventIndex].isSelected = !_events[eventIndex].isSelected;
            });
          } else {
            await Clipboard.setData(
              ClipboardData(
                text: event.message,
              ),
            );
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.teal,
                  duration: Duration(milliseconds: 300),
                  content: Text('Copied to clipboard'),
                ),
              );
            }
          }
        },
        onHorizontalDragEnd: (_) {
          setState(() {
            _isMessageEditMode = true;
            _messageIndex = eventIndex;
          });
          _controller.text = event.message;
        },
        child: _messageEventBody(event, timeMark),
      ),
    );
  }

  Widget _messageEventBody(Event event, String timeMark) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 350,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      margin: const EdgeInsets.only(left: 5, bottom: 7),
      decoration: BoxDecoration(
        color: event.isSelected ? Colors.amber : Colors.lime.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.message,
              style: const TextStyle(
                color: Colors.black,
              )),
          const SizedBox(height: 3),
          Text(
            timeMark,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
