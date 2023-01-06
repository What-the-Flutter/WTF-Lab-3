import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'chat.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    // final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.title),
        centerTitle: true,
      ),
      body: Center(
        child: Text(widget.chat.messages.toString()),
      ),
    );
  }
}
