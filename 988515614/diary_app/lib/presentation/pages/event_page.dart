import 'dart:io';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:diary_app/domain/entities/event.dart';
import 'package:flutter/material.dart';
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
    ),
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
  ];

  final TextEditingController _controller = TextEditingController();
  bool _isEditing = false;

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
      leading: IconButton(
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
      actions: [
        IconButton(
          splashRadius: 20,
          icon: const Icon(CarbonIcons.search),
          onPressed: () {},
        ),
        IconButton(
          splashRadius: 20,
          icon: const Icon(CarbonIcons.bookmark),
          onPressed: () {},
        ),
      ],
    );
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
              ? IconButton(
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
                )
              : IconButton(
                  splashRadius: 20,
                  icon: const Icon(
                    CarbonIcons.camera,
                    size: 30,
                  ),
                  color: Colors.teal,
                  onPressed: () async {
                    await _showImageDialog();
                  },
                ),
        ],
      ),
    );
  }

  Future<void> _showImageDialog() async {
    final dialog = AlertDialog(
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

    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: ListView.separated(
            reverse: true,
            shrinkWrap: true,
            itemCount: _events.length,
            itemBuilder: (context, index) {
              return _buildEventListItem(_events[_events.length - 1 - index]);
            },
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 10,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildEventListItem(Event event) {
    final timeMark = DateFormat('hh:mm a').format(event.dateTime);

    if (event.isMessage) {
      return event.image == null
          ? Align(
              alignment: Alignment.centerLeft,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 350,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.lime.shade200,
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
            )
          : Align(
              alignment: Alignment.centerLeft,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 350,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.lime.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                        maxHeight: 200,
                      ),
                      child: Flexible(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: event.image,
                        ),
                      ),
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
            );
    } else {
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
          margin: const EdgeInsets.only(left: 5),
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
  }
}
