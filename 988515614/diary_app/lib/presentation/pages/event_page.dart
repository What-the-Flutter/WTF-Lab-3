import 'dart:io';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:diary_app/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final List<Event> _events = [
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

  final TextEditingController _controller = TextEditingController();
  bool _isEditing = false;
  bool _selectionMode = false;
  bool _messageEditMode = false;
  bool _bookmarkMode = false;
  int _messageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  } // Mocked data

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: _selectionMode
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
      title: const Text(
        'Travel',
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: _buildAppbarActions(),
    );
  }

  List<Widget> _buildAppbarActions() {
    return _selectionMode
        ? _buildSelectionModeActions()
        : _buildDefaultModeActions();
  }

  List<Widget> _buildSelectionModeActions() {
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
        icon: _bookmarkMode
            ? const Icon(CarbonIcons.favorite_half)
            : const Icon(CarbonIcons.favorite),
        onPressed: () {
          setState(() {
            if (_bookmarkMode) {
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

  List<Widget> _buildDefaultModeActions() {
    return [
      IconButton(
        splashRadius: 20,
        icon: const Icon(CarbonIcons.search),
        onPressed: () {},
      ),
      IconButton(
        splashRadius: 20,
        icon: _bookmarkMode
            ? const Icon(CarbonIcons.bookmark_filled)
            : const Icon(CarbonIcons.bookmark),
        onPressed: () {
          setState(() {
            _bookmarkMode = !_bookmarkMode;
          });
        },
      ),
    ];
  }

  void _turnOffSelectionMode() {
    setState(() {
      _selectionMode = false;
      for (var e in _events) {
        e.isSelected = false;
      }
    });
  }

  Widget _buildBody() {
    return Column(
      children: [
        Flexible(
          child: _buildEventsList(),
        ),
        _buildMessagePanel(),
      ],
    );
  }

  Widget _buildTextField() {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          _isEditing = value;
        });
      },
      child: TextField(
        controller: _controller,
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

  Widget _buildMessagePanel() {
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
            child: _buildTextField(),
          ),
          _isEditing
              ? _buildSendButtonVariants()
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

  Widget _buildSendButtonVariants() {
    return _messageEditMode ? _buildEditButton() : _buildSendButton();
  }

  Widget _buildEditButton() {
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
          _messageEditMode = false;
          _messageIndex = 0;
        });
      },
    );
  }

  Widget _buildSendButton() {
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
    final dialog = _buildImageDialog();

    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }

  Widget _buildImageDialog() {
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

  Widget _buildEventsList() {
    return _events.isEmpty ? _buildIntro() : _buildEvents();
  }

  Widget _buildIntro() {
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

  Widget _buildEvents() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _bookmarkMode ? _buildBookmarkedEvents() : _buildAllEvents(),
      ],
    );
  }

  Widget _buildBookmarkedEvents() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        reverse: true,
        shrinkWrap: true,
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return _events[_events.length - 1 - index].isFavorite
              ? _buildEventListItem(
                  _events[_events.length - 1 - index],
                  _events.length - 1 - index,
                )
              : Container();
        },
      ),
    );
  }

  Widget _buildAllEvents() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        reverse: true,
        shrinkWrap: true,
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return _buildEventListItem(
            _events[_events.length - 1 - index],
            _events.length - 1 - index,
          );
        },
      ),
    );
  }

  Widget _buildEventListItem(Event event, int eventIndex) {
    final timeMark = DateFormat('hh:mm a').format(event.dateTime);

    if (event.isMessage) {
      return event.image == null
          ? _buildMessageEvent(event, eventIndex, timeMark)
          : _buildPictureEvent(event, eventIndex, timeMark);
    } else {
      return _buildTimeEvent(event);
    }
  }

  Widget _buildTimeEvent(Event event) {
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
            Text(event.message),
          ],
        ),
      ),
    );
  }

  Widget _buildPictureEvent(Event event, int eventIndex, String timeMark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            if (!_selectionMode) {
              _selectionMode = true;
              _events[eventIndex].isSelected = !_events[eventIndex].isSelected;
            }
          });
        },
        onTap: () async {
          if (_selectionMode) {
            setState(() {
              _events[eventIndex].isSelected = !_events[eventIndex].isSelected;
            });
          }
        },
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
            color: event.isSelected ? Colors.amber : Colors.lime.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.amber,
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
        ),
      ),
    );
  }

  Widget _buildMessageEvent(Event event, int eventIndex, String timeMark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            if (!_selectionMode) {
              _selectionMode = true;
              _events[eventIndex].isSelected = !_events[eventIndex].isSelected;
            }
          });
        },
        onTap: () async {
          if (_selectionMode) {
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
            _messageEditMode = true;
            _messageIndex = eventIndex;
          });
          _controller.text = event.message;
        },
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
            color: event.isSelected ? Colors.amber : Colors.lime.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.message),
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
        ),
      ),
    );
  }
}
