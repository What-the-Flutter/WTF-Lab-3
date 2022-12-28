// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:diary_app/custom_theme.dart';
import 'package:diary_app/domain/entities/chat.dart';
import 'package:diary_app/domain/entities/icon.dart';

class CreateChat extends StatefulWidget {
  final String title;

  const CreateChat({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  final _controller = TextEditingController();
  final _iconTiles = [
    ChatIcon(iconData: Icons.abc, isSelected: true),
    ChatIcon(iconData: Icons.hail, isSelected: false),
    ChatIcon(iconData: Icons.dangerous_outlined, isSelected: false),
    ChatIcon(iconData: Icons.label_important, isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: Scaffold(
        body: _body(),
        floatingActionButton: _fab(),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _title(),
        _textField(),
        _icons(),
      ],
    );
  }

  Widget _fab() {
    return FloatingActionButton(
      splashColor: Colors.yellowAccent,
      backgroundColor: Colors.yellow.shade700,
      onPressed: () {
        if (_controller.text.isEmpty) {
          showWarning();
          return;
        }
        Navigator.of(context).pop(getNewChatData());
      },
      child: const Icon(
        Icons.done,
        size: 30,
        color: Colors.black,
      ),
    );
  }

  Chat getNewChatData() {
    var icon = _iconTiles.where((element) => element.isSelected).first.iconData;
    var title = _controller.text.toString();

    var newChat = Chat(
      icon: icon,
      title: title,
      createdAt: DateTime.now(),
    );

    return newChat;
  }

  void showWarning() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Empty title'),
        duration: Duration(milliseconds: 700),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomTheme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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

  Widget _icons() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: _iconTiles.length,
        itemBuilder: (context, index) {
          var chatIcon = _iconTiles[index];
          return GestureDetector(
            onTap: () => setState(() {
              _deselectAll();
              _iconTiles[index].isSelected = true;
            }),
            child: _icon(
              chatIcon.iconData,
              chatIcon.isSelected,
            ),
          );
        },
      ),
    );
  }

  void _deselectAll() {
    setState(() {
      for (var element in _iconTiles) {
        element.isSelected = false;
      }
    });
  }

  Widget _icon(IconData iconData, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomTheme.of(context).primaryColor,
        ),
        width: 30,
        height: 30,
        child: Icon(iconData,
            size: 50,
            color: isSelected
                ? Colors.amber
                : CustomTheme.of(context).primaryColorLight),
      ),
    );
  }
}
