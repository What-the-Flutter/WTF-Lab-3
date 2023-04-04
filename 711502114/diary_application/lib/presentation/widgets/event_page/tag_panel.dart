import 'package:diary_application/domain/utils/hash_tag.dart';
import 'package:diary_application/presentation/pages/chat/event_state.dart';
import 'package:flutter/material.dart';

class TagPanel extends StatelessWidget {
  final TextEditingController controller;
  final EventState state;

  const TagPanel({
    Key? key,
    required this.controller,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text('${HashTag.extract(controller.text).last}'),
      ),
    );
  }
}
