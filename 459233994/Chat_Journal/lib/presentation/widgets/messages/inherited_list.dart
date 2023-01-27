import 'package:flutter/material.dart';

import '../../../domain/entities/packed_message.dart';

class InheritedList extends InheritedWidget {
  final List<PackedMessage> events;
  final bool favoritesMode;
  final Function() notifyParent;
  @override
  final Widget child;

  InheritedList({
    required this.child,
    required this.events,
    required this.favoritesMode,
    required this.notifyParent,
  }) : super(child: child);

  static InheritedList? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedList>();
  }

  @override
  bool updateShouldNotify(InheritedList oldWidget) {
    return oldWidget.events != events || oldWidget.favoritesMode != favoritesMode || oldWidget.notifyParent != notifyParent;
  }
}
