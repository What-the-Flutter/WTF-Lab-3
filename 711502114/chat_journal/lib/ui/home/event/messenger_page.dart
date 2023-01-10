import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../chat.dart';
import 'event.dart';
import 'info_box.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chat.title),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: IconButton(
                icon: const Icon(Icons.bookmark_border_outlined),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.chat.messages.isNotEmpty
                  ? _buildMessageList(size)
                  : InfoBox(size: size, mainTitle: widget.chat.title),
              _getInputBox(size),
            ],
          ),
        ));
  }

  Expanded _buildMessageList(Size size) {
    return Expanded(

      child: ListView.builder(
        reverse: true,
        itemCount: widget.chat.messages.length,
        itemBuilder: (context, index) {
          return Event(
            messageData: widget.chat.messages[index],
            size: size,
          );
        },
      ),
    );
  }

  Container _getInputBox(Size size) {
    String message = "";
    return Container(
      width: size.width,
      color: messageBlocColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.attach_file,
              size: 24,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter event',
                hintStyle: TextStyle(fontSize: 20),
              ),
              style: const TextStyle(fontSize: 20),
              onChanged: (text) {
                message = text;
              },
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.send,
              size: 24,
            ),
            onPressed: () {
              // text
            },
          ),
        ],
      ),
    );
  }
}
