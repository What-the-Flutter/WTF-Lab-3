// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:diary_app/data/all_icons.dart';
import 'package:diary_app/domain/entities/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:diary_app/domain/entities/event.dart';
import 'package:diary_app/domain/entities/event_category.dart';
import 'package:diary_app/presentation/pages/chat_page/chat_cubit.dart';
import 'package:diary_app/presentation/pages/chat_page/chat_state.dart';

class ChatPage extends StatefulWidget {
  final List<Chat> chats;
  final String title;
  final int chatId;
  const ChatPage({
    Key? key,
    required this.chats,
    required this.title,
    required this.chatId,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _searchController = TextEditingController();

  var _isEditing = false;
  var _isSelectionMode = false;
  var _isMessageEditMode = false;
  var _isBookmarkMode = false;
  var _isSearchMode = false;

  var _messageIndex = 0;
  var _messageId = 0;
  EventCategory? _chosenCategory = null;

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
              onPressed: () => _turnOffSelectionMode(),
            )
          : IconButton(
              splashRadius: 20,
              icon: const Icon(CarbonIcons.arrow_left),
              onPressed: () => Navigator.of(context).pop(),
            ),
      title: _isSearchMode
          ? _searchField()
          : Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
      actions: _appbarActions(),
    );
  }

  List<Widget> _appbarActions() => _isSearchMode
      ? _searchModeActions()
      : _isSelectionMode
          ? _selectionModeActions()
          : _defaultModeActions();

  List<Widget> _searchModeActions() {
    return [
      IconButton(
        splashRadius: 20,
        icon: const Icon(CarbonIcons.close),
        onPressed: () {
          setState(() {
            _isSearchMode = false;
            BlocProvider.of<ChatCubit>(context).unmarkSearchResults();
            _searchController.clear();
          });
        },
      ),
    ];
  }

  Widget _searchField() => Focus(
        onFocusChange: (value) {
          setState(() {
            _isEditing = value;
            _chosenCategory = null;
          });
        },
        child: TextField(
          controller: _searchController,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(10),
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
          onChanged: (value) {
            setState(() {
              BlocProvider.of<ChatCubit>(context).getSearchResult(value);
            });
          },
        ),
      );

  List<Widget> _selectionModeActions() {
    return [
      IconButton(
        splashRadius: 20,
        icon: const Icon(CarbonIcons.arrow_down_left),
        onPressed: () async {
          final targetChatId = await showDialog(
            context: context,
            builder: (context) => _migrateDialog(),
          ) as int?;
          if (!mounted || targetChatId == null) return;

          await BlocProvider.of<ChatCubit>(context).moveSelectedItems(targetChatId);
          _turnOffSelectionMode();
        },
      ),
      IconButton(
        splashRadius: 20,
        icon: const Icon(CarbonIcons.delete),
        onPressed: () async {
          await BlocProvider.of<ChatCubit>(context).removeSelectedItems();
          _turnOffSelectionMode();
        },
      ),
      IconButton(
        splashRadius: 20,
        icon: _isBookmarkMode
            ? const Icon(CarbonIcons.favorite_half)
            : const Icon(CarbonIcons.favorite),
        onPressed: () async {
          if (_isBookmarkMode) {
            await BlocProvider.of<ChatCubit>(context).changeFavoriteness(false);
          } else {
            await BlocProvider.of<ChatCubit>(context).changeFavoriteness(true);
          }

          _turnOffSelectionMode();
        },
      ),
    ];
  }

  AlertDialog _migrateDialog() {
    final chats = widget.chats;
    return AlertDialog(
      title: const Text('Choose where to migrate'),
      content: SizedBox(
        width: 200,
        height: 200,
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  if (chat.id != widget.chatId) {
                    return ListTile(
                      title: Text(chat.title), // ! HERE
                      onTap: () {
                        Navigator.of(context).pop(chat.id);
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }

  List<Widget> _defaultModeActions() {
    return [
      IconButton(
        splashRadius: 20,
        icon: const Icon(CarbonIcons.search),
        onPressed: () {
          setState(() {
            _isSearchMode = true;
          });
        },
      ),
      IconButton(
        splashRadius: 20,
        icon: _isBookmarkMode
            ? const Icon(CarbonIcons.bookmark_filled)
            : const Icon(CarbonIcons.bookmark),
        onPressed: () => setState(() => _isBookmarkMode = !_isBookmarkMode),
      ),
    ];
  }

  void _turnOffSelectionMode() {
    setState(() {
      _isSelectionMode = false;
    });
    BlocProvider.of<ChatCubit>(context).removeSelections();
  }

  Widget _body() {
    return Column(
      children: [
        Flexible(
          child: BlocBuilder<ChatCubit, ChatEventsUpdated>(
            builder: (context, state) {
              return _eventsList();
            },
          ),
        ),
        _messagePanel(),
      ],
    );
  }

  Widget _textField() {
    return Focus(
      onFocusChange: (value) {
        setState(() => _isEditing = value);
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
            icon: Icon(
              _chosenCategory?.icon ?? CarbonIcons.ai_results,
              size: 30,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: _categoriesPicker(),
                  duration: const Duration(days: 1),
                ),
              );
            },
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
                  onPressed: () => _showImageDialog(),
                ),
        ],
      ),
    );
  }

  Widget _categoriesPicker() {
    final titles = ['Food', 'Weather', 'Emotions'];
    final categories = List<EventCategory>.generate(
      titles.length,
      (index) => EventCategory(title: titles[index], icon: allIcons[index]),
    );

    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return TextButton(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(category.title),
                      Icon(
                        category.icon,
                        color: category.title == 'Close' ? Colors.red : Colors.teal,
                        size: 30,
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (category.title == 'Close') {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      setState(() {
                        _chosenCategory = null;
                      });
                      return;
                    }
                    setState(() {
                      _chosenCategory = category;
                    });
                    ScaffoldMessenger.of(context).clearSnackBars();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sendButtonVariants() => _isMessageEditMode ? _editButton() : _sendButton();

  Widget _editButton() {
    return IconButton(
      splashRadius: 20,
      icon: const Icon(
        CarbonIcons.change_catalog,
        size: 30,
      ),
      color: Colors.teal,
      onPressed: () async {
        if (_controller.text.isEmpty) return;
        await BlocProvider.of<ChatCubit>(context).editEvent(
          _messageIndex,
          Event(
            id: _messageId,
            chatId: widget.chatId,
            isMessage: true,
            dateTime: DateTime.now(),
            message: _controller.text.toString(),
            category: _chosenCategory,
          ),
        );

        _controller.clear();
        setState(() {
          _chosenCategory = null;
          _isMessageEditMode = false;
          _messageIndex = 0;
          _messageId = 0;
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
      onPressed: () async {
        if (_controller.text.isEmpty) return;
        await BlocProvider.of<ChatCubit>(context).addEvent(
          Event(
            id: -1,
            chatId: widget.chatId,
            isMessage: true,
            dateTime: DateTime.now(),
            message: _controller.text.toString(),
            category: _chosenCategory,
          ),
        );
        setState(() {
          _chosenCategory = null;
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
            await _createEventWithPicture(pickedFile);
          },
        ),
      ],
    );
  }

  Future<void> _createEventWithPicture(XFile? pickedFile) async {
    if (pickedFile != null) {
      await BlocProvider.of<ChatCubit>(context).addEvent(
        Event(
          id: -1,
          chatId: widget.chatId,
          isMessage: true,
          dateTime: DateTime.now(),
          message: "",
          image: base64Encode(await pickedFile.readAsBytes()),
          category: _chosenCategory,
        ),
      );
    }
  }

  Widget _eventsList() => BlocProvider.of<ChatCubit>(context).isEmpty ? _intro() : _eventsViews();

  Widget _intro() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
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
                    '\neverything about the topic!',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Add first event to this page by\n'
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
        ],
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
    return BlocBuilder<ChatCubit, ChatEventsUpdated>(
      builder: (context, state) {
        final events = state.chatEvents;

        return Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            reverse: true,
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              // Display events in reverse order
              return events[events.length - 1 - index].isFavorite &&
                      events[events.length - 1 - index].isDisplayed
                  ? _eventListItem(
                      events[events.length - 1 - index],
                      events.length - 1 - index,
                    )
                  : Container();
            },
          ),
        );
      },
    );
  }

  Widget _allEvents() {
    return BlocBuilder<ChatCubit, ChatEventsUpdated>(
      builder: (context, state) {
        final events = state.chatEvents;

        return Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            reverse: true,
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return events[events.length - 1 - index].isDisplayed
                  ? _eventListItem(
                      events[events.length - 1 - index],
                      events.length - 1 - index,
                    )
                  : Container();
            },
          ),
        );
      },
    );
  }

  Widget _eventListItem(Event event, int eventIndex) {
    final timeMark = DateFormat('hh:mm a').format(event.dateTime);

    if (event.isMessage) {
      return event.image == 'null' || event.image == null
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
              BlocProvider.of<ChatCubit>(context).unmarkSearchResults();
              _isSearchMode = false;
              BlocProvider.of<ChatCubit>(context).changeSelectionState(eventIndex);
            }
          });
        },
        onTap: () async {
          if (_isSelectionMode) {
            BlocProvider.of<ChatCubit>(context).changeSelectionState(eventIndex);
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
            child: Image.memory(
              base64Decode(event.image!),
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
              BlocProvider.of<ChatCubit>(context).unmarkSearchResults();
              _isSearchMode = false;
              BlocProvider.of<ChatCubit>(context).changeSelectionState(eventIndex);
            }
          });
        },
        onTap: () async {
          if (_isSelectionMode) {
            setState(() => BlocProvider.of<ChatCubit>(context).changeSelectionState(eventIndex));
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
        onVerticalDragEnd: (_) {
          setState(() {
            _isMessageEditMode = true;
            _messageIndex = eventIndex;
            _messageId = event.id;
          });
          _controller.text = event.message;
        },
        onHorizontalDragEnd: (_) async {
          await BlocProvider.of<ChatCubit>(context).removeItemById(
            event.id,
            eventIndex,
          );
          setState(() {});
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
