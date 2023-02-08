import 'package:flutter/material.dart';

import '../../../domain/entities/event_page.dart';
import '../../screens/add_event_page.dart';
import '../../screens/messages.dart';
import '../app_theme/inherited_app_theme.dart';

class EventList extends StatefulWidget {
  final List<EventPage> _pages;
  final Function _refresh;

  EventList({
    required pages,
    required refreshFunc,
  })  : _pages = pages,
        _refresh = refreshFunc;

  @override
  State<EventList> createState() => _EventListState(pages: _pages);
}

class _EventListState extends State<EventList> {
  final List<EventPage> _pages;
  final List<EventPage> _pinnedPages = [];

  _EventListState({required pages}) : _pages = pages;

  Widget _listView(List<EventPage> pages, bool pinableList) {
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

  Widget _bottomShield(BuildContext context, EventPage page) {
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

  Widget _setPinableIcon(EventPage page) {
    if (page.isPinned) {
      print(1111);
      return SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          children: <Widget>[
            Center(child: page.pageIcon),
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
        child: Center(child: page.pageIcon),
      );
    }
  }

  Future<void> _showDialog(EventPage page) async {
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
                  padding: EdgeInsets.all(0),
                  // padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      page.pageIcon,
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
                          page.createTime,
                          style: TextStyle(
                            color:
                                InheritedAppTheme.of(context)?.getTheme.textColor,
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
    for (var i = 0; i < _pages.length; i++) {
      if (_pages[i].isPinned == true) {
        _pinnedPages.add(_pages[i]);
      }
    }
    print(_pinnedPages.length);
  }

  void _edit(BuildContext context, EventPage page) async {
    var edited = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventPage(
          theme: InheritedAppTheme.of(context)?.getTheme,
        ),
      ),
    );
    if (edited != null) {
      _pages[_pages.indexOf(page)] = _pages[_pages.indexOf(page)].copyWith(
        name: edited.name,
        pageIcon: edited.pageIcon,
        isPinned: edited.isPinned,
      );
      widget._refresh();
      Navigator.pop(context);
    }
  }

  void _delete(BuildContext context, EventPage page) {
    _pages.removeAt(_pages.indexOf(page));
    widget._refresh();
    Navigator.pop(context);
  }

  void _pin(BuildContext context, EventPage page) {
    if (_pages[_pages.indexOf(page)].isPinned == true) {
      _pages[_pages.indexOf(page)] =
          _pages[_pages.indexOf(page)].copyWith(isPinned: false);
    } else {
      _pages[_pages.indexOf(page)] =
          _pages[_pages.indexOf(page)].copyWith(isPinned: true);
    }
    setState(() {});
    Navigator.pop(context);
  }

  void _tapHandler(BuildContext context, EventPage page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MessagesScreen(
          theme: InheritedAppTheme.of(context)?.getTheme,
          title: page.name,
        ),
      ),
    );
  }

  void _longPressHandler(BuildContext context, EventPage page) {
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

  @override
  Widget build(BuildContext context) {
    _setPinnedPages();
    return Column(
      children: <Widget>[
        _listView(_pinnedPages, true),
        _listView(_pages, false),
      ],
    );
  }
}
