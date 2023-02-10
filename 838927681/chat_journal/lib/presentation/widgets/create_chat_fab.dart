import 'package:flutter/material.dart';

class CreateChatFAB extends StatefulWidget {
  const CreateChatFAB({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<CreateChatFAB> createState() => _CreateChatFABState();
}

class _CreateChatFABState extends State<CreateChatFAB> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      child: FloatingActionButton(
        child: Icon(
          widget.controller.text.isNotEmpty
              ? Icons.done
              : Icons.cancel_outlined,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 0,
      bottom: 0,
    );
  }
}
