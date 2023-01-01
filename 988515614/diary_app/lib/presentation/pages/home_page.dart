import 'package:carbon_icons/carbon_icons.dart';
import 'package:diary_app/presentation/pages/create_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../custom_theme.dart';
import '../../domain/entities/chat.dart';
import '../widgets/question_button.dart';
import 'event_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;

  final List<Chat> _tempChats = [
    Chat(
        icon: CarbonIcons.departure,
        title: 'Travel',
        createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.pedestrian_family,
        title: 'Family',
        createdAt: DateTime.now()),
    Chat(icon: CarbonIcons.trophy, title: 'Sports', createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.game_console,
        title: 'Chill',
        createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.workspace,
        title: 'Projects',
        createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.navaid_civil,
        title: 'Goals',
        createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.face_activated_add,
        title: 'Mood',
        createdAt: DateTime.now()),
    Chat(icon: CarbonIcons.satellite, title: 'Work', createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.gas_station,
        title: 'Mechanics',
        createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.keyboard,
        title: 'Programming',
        createdAt: DateTime.now()),
    Chat(icon: CarbonIcons.watson, title: 'Ideas', createdAt: DateTime.now()),
    Chat(
        icon: CarbonIcons.quadrant_plot,
        title: 'Stats',
        createdAt: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _content(context),
        _fab(context),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        QuestionButton(
          onPressed: () {},
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: ((notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                if (_isVisible == true) {
                  setState(() {
                    _isVisible = false;
                  });
                }
              } else if (direction == ScrollDirection.forward) {
                if (_isVisible == false) {
                  setState(() {
                    _isVisible = true;
                  });
                }
              }
              return true;
            }),
            child: _chats(),
          ),
        ),
      ],
    );
  }

  Widget _chats() {
    return ListView.separated(
      itemCount: _tempChats.length,
      itemBuilder: (context, index) {
        final chatData = _tempChats[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onLongPress: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => _bottomSheet(index),
              );
            },
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return EventPage(
                    title: _tempChats[index].title,
                  );
                }),
              );
            },
            child: _chatContent(chatData),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black,
        );
      },
    );
  }

  Widget _chatContent(Chat chatData) {
    return ListTile(
      leading: Icon(
        chatData.icon,
        size: 30,
      ),
      title: Text(
        chatData.title + (chatData.isPinned ? ' 📌' : ''),
        style: TextStyle(
          color: CustomTheme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      subtitle: Text(
        chatData.lastMessage ?? 'No events. Click to create one',
        style: TextStyle(
          color: CustomTheme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      trailing: Text(
        chatData.updatedAt != null
            ? DateFormat('hh:mm a').format(chatData.updatedAt!).toString()
            : '',
        style: TextStyle(
          color: CustomTheme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

  Widget _bottomSheet(int index) {
    return Wrap(
      children: [
        _infoButton(index),
        _pinUnpinButton(index),
        _archiveButton(index),
        _editButton(index),
        _deleteButton(index),
      ],
    );
  }

  Widget _infoButton(int index) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () {
        var chat = _tempChats[index];
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _dialog(chat);
          },
        );
      },
      child: ListTile(
        leading: const Icon(CarbonIcons.information),
        title: Text(
          'Info',
          style: TextStyle(
            color: CustomTheme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _dialog(Chat chat) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(chat.icon),
          const SizedBox(width: 7),
          Text(
            chat.title,
            style: TextStyle(
              color: CustomTheme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
      content: _dialogContent(chat),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _dialogContent(Chat chat) {
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created at:\n${DateFormat('hh:mm a').format(chat.createdAt)}',
              style: TextStyle(
                color: CustomTheme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Last updated at:\n${chat.updatedAt != null ? DateFormat('hh:mm a').format(chat.updatedAt!) : 'No messages yet'}',
              style: TextStyle(
                color: CustomTheme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _pinUnpinButton(int index) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () {
        if (_tempChats[index].isPinned) {
          setState(() {
            _tempChats[index].isPinned = false;
          });
          Navigator.of(context).pop();
          return;
        }
        var lastPinnedIndex =
            _tempChats.lastIndexWhere((element) => element.isPinned);
        setState(() {
          var chat = _tempChats.removeAt(index);
          chat.isPinned = true;
          _tempChats.insert(lastPinnedIndex + 1, chat);
        });
        Navigator.of(context).pop();
      },
      child: ListTile(
        leading: const Icon(
          CarbonIcons.pin,
          color: Colors.green,
        ),
        title: Text(
          'Pin/Unpin Chat',
          style: TextStyle(
            color: CustomTheme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _archiveButton(int index) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: ListTile(
        leading: const Icon(
          CarbonIcons.save,
          color: Colors.orange,
        ),
        title: Text(
          'Archive Chat',
          style: TextStyle(
            color: CustomTheme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _editButton(int index) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () async {
        Chat? result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const CreateChat(
                  title: 'Edit chat',
                ))) as Chat?;

        setState(() {
          if (result != null) {
            _tempChats[index].icon = result.icon;
            _tempChats[index].title = result.title;
          }
        });

        if (!mounted) return;

        Navigator.of(context).pop();
      },
      child: ListTile(
        leading: const Icon(
          CarbonIcons.edit,
          color: Colors.blue,
        ),
        title: Text(
          'Edit Chat',
          style: TextStyle(
            color: CustomTheme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _deleteButton(int index) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () {
        setState(() {
          _tempChats.removeAt(index);
        });
        Navigator.of(context).pop();
      },
      child: ListTile(
        leading: const Icon(
          CarbonIcons.trash_can,
          color: Colors.red,
        ),
        title: Text(
          'Delete Chat',
          style: TextStyle(
            color: CustomTheme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _fab(BuildContext context) {
    return AnimatedPositioned(
      right: _isVisible ? 15 : -100,
      bottom: 15,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: FloatingActionButton(
        splashColor: Colors.yellowAccent,
        backgroundColor: Colors.yellow.shade700,
        onPressed: () async {
          Chat? result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const CreateChat(
                    title: 'Create new chat',
                  ))) as Chat?;

          setState(() {
            if (result != null) {
              var lastPinnedIndex =
                  _tempChats.lastIndexWhere((element) => element.isPinned);
              _tempChats.insert(lastPinnedIndex + 1, result);
            }
          });
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
