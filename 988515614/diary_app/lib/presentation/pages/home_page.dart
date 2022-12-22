import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/temp_data.dart';
import '../widgets/chat_list.dart';
import '../widgets/question_button.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(true);

    return Stack(
      children: [
        _buildContent(context, isVisible),
        _buildFab(isVisible),
      ],
    );
  }

  Widget _buildFab(ValueNotifier<bool> isVisible) {
    return AnimatedPositioned(
      right: isVisible.value ? 15 : -100,
      bottom: 15,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: FloatingActionButton(
        splashColor: Colors.yellowAccent,
        backgroundColor: Colors.yellow.shade700,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ValueNotifier<bool> isVisible) {
    return Column(
      children: [
        QuestionButton(
          onPressed: () {},
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: ((notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                if (isVisible.value == true) {
                  isVisible.value = false;
                }
              } else if (direction == ScrollDirection.forward) {
                if (isVisible.value == false) {
                  isVisible.value = true;
                }
              }
              return true;
            }),
            child: ChatList(
              chats: tempChats,
            ),
          ),
        ),
      ],
    );
  }
}
