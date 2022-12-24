import 'package:flutter/cupertino.dart';

class Chat {
  final Icon icon;
  final String title;
  final Widget? url;
  Chat({
    required this.icon,
    required this.title,
    this.url,
  });
}
