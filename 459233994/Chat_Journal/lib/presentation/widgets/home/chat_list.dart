import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/chat.dart';
import '../../screens/add_chat.dart';
import '../../screens/chat/chat.dart';
import '../../screens/home/home_cubit.dart';
import '../../screens/home/home_state.dart';
import '../app_theme/inherited_app_theme.dart';

class ChatList extends StatefulWidget {
  final List<Chat> _pages;

  ChatList({
    required pages,
  }) : _pages = pages;

  @override
  State<ChatList> createState() => _ChatListState(pages: _pages);
}

class _ChatListState extends State<ChatList> {
  final List<Chat> _pages = [];
  final List<Chat> _pinnedPages = [];
  final DateFormat formatter = DateFormat('Hm');

  _ChatListState({required pages});

  @override
  Widget build(BuildContext context) {
    _pages.clear();
    _pages.addAll(ReadContext(context).read<HomeCubit>().getChats());
    _setPinnedPages();
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Column(
        children: <Widget>[
          _listView(_pinnedPages, true),
          _listView(_pages, false),
        ],
      );
    });
  }

  Widget _listView(List<Chat> pages, bool pinableList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pages.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        if ((!pinableList && !pages[index].isPinned) ||
            (pinableList && pages[index].isPinned)) {
          return ListTile(
            title: Text(
              pages[index].name,
              style: TextStyle(
                  color: InheritedAppTheme.of(context)?.getTheme.textColor),
            ),
            subtitle: Text(
              'No events',
              style: TextStyle(
                  color: InheritedAppTheme.of(context)?.getTheme.textColor),
            ),
            leading: _setPinableIcon(pages[index]),
            onTap: () => _tapHandler(
              context,
              index,
              _pages[_pages.indexOf(
                pages[index],
              )],
            ),
            onLongPress: () => _longPressHandler(
              context,
              _pages[_pages.indexOf(
                pages[index],
              )],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _bottomShield(BuildContext context, Chat page) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(
            Icons.info,
            color: Colors.green,
          ),
          title: Text(
            'Info',
            style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor),
          ),
          onTap: () {
            _showDialog(page);
          },
        ),
        ListTile(
            leading: const Icon(
              Icons.push_pin,
              color: Colors.lightGreen,
            ),
            title: Text(
              'Pin/Unpin Page',
              style: TextStyle(
                  color: InheritedAppTheme.of(context)?.getTheme.textColor),
            ),
            onTap: () {
              _pin(context, page);
            }),
        ListTile(
          leading: const Icon(
            Icons.archive,
            color: Colors.yellow,
          ),
          title: Text(
            'Archive Page',
            style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          title: Text(
            'Edit',
            style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor),
          ),
          onTap: () {
            _edit(context, page);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          title: Text(
            'Delete',
            style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor),
          ),
          onTap: () {
            _delete(context, page);
          },
        ),
      ],
    );
  }

  Widget _setPinableIcon(Chat page) {
    if (page.isPinned) {
      return SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          children: <Widget>[
            Center(
              child: Icon(page.pageIcon,
                  color: InheritedAppTheme.of(context)?.getTheme.iconColor),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.push_pin,
                color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                size: 15,
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Icon(page.pageIcon,
              color: InheritedAppTheme.of(context)?.getTheme.iconColor),
        ),
      );
    }
  }

  Future<void> _showDialog(Chat page) async {
    Navigator.pop(context);
    await showDialog<void>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor:
              InheritedAppTheme.of(context)?.getTheme.backgroundColor,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  // padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(page.pageIcon,
                          color: InheritedAppTheme.of(context)
                              ?.getTheme
                              .iconColor),
                      Text(
                        page.name,
                        style: TextStyle(
                          color:
                              InheritedAppTheme.of(context)?.getTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, left: 30),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        'Created',
                        style: TextStyle(
                          color:
                              InheritedAppTheme.of(context)?.getTheme.textColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          formatter.format(page.createTime),
                          style: TextStyle(
                            color: InheritedAppTheme.of(context)
                                ?.getTheme
                                .textColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, left: 30),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'latest event',
                    style: TextStyle(
                      color: InheritedAppTheme.of(context)?.getTheme.textColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ok',
                      style: TextStyle(
                        color:
                            InheritedAppTheme.of(context)?.getTheme.textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _setPinnedPages() {
    _pinnedPages.clear();
    // var pages = ReadContext(context).read<HomeCubit>().getChats();
    for (var i = 0; i < _pages.length; i++) {
      if (_pages[i].isPinned == true) {
        _pinnedPages.add(_pages[i]);
      }
    }
  }

  void _edit(BuildContext context, Chat chat) async {
    var edited = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddChatScreen(),
      ),
    );
    if (edited != null) {
      ReadContext(context).read<HomeCubit>().editChat(
            editedChat: chat.copyWith(
              name: edited.name,
              pageIcon: edited.pageIcon,
              isPinned: edited.isPinned,
            ),
          );
      Navigator.pop(context);
    }
  }

  void _delete(BuildContext context, Chat chat) {
    ReadContext(context).read<HomeCubit>().deleteChat(chat: chat);
    Navigator.pop(context);
  }

  void _pin(BuildContext context, Chat chat) {
    ReadContext(context)
        .read<HomeCubit>()
        .pinChat(chat: chat.copyWith(isPinned: !chat.isPinned));
    Navigator.pop(context);
  }

  void _tapHandler(BuildContext context, int index, Chat page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          chat: ReadContext(context).read<HomeCubit>().getChat(index),
        ),
      ),
    );
  }

  void _longPressHandler(BuildContext context, Chat page) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
        child: _bottomShield(
          context,
          page,
        ),
      ),
    );
  }
}
