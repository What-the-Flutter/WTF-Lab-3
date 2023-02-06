import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPage {
  final String _name;
  final DateTime _createTime = DateTime.now();
  final DateFormat formatter = DateFormat('yMd');
  final Icon _pageIcon;
  final bool _isPinned;

  EventPage({
    required name,
    required pageIcon,
    isPinned,
  })  : _name = name,
        _pageIcon = pageIcon, _isPinned = isPinned ?? false;

  String get name => _name;

  Icon get pageIcon => _pageIcon;

  bool get isPinned => _isPinned;

  String get createTime => formatter.format(_createTime);

  EventPage copyWith({String? name, Icon? pageIcon, bool? isPinned}) {
    return EventPage(
      name: name ?? _name,
      pageIcon: pageIcon ?? _pageIcon,
      isPinned: isPinned ?? _isPinned,
    );
  }
}
