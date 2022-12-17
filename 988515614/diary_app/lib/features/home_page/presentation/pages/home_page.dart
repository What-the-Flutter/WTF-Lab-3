import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/entities/chat.dart';
import '../widgets/chat_list.dart';
import '../widgets/question_button.dart';

class HomePage extends HookWidget {
  final List<Chat> chats = [
    Chat(icon: CarbonIcons.departure, title: 'Travel'),
    Chat(icon: CarbonIcons.pedestrian_family, title: 'Family'),
    Chat(icon: CarbonIcons.trophy, title: 'Sports'),
    Chat(icon: CarbonIcons.game_console, title: 'Chill'),
    Chat(icon: CarbonIcons.workspace, title: 'Projects'),
    Chat(icon: CarbonIcons.navaid_civil, title: 'Goals'),
    Chat(icon: CarbonIcons.face_activated_add, title: 'Mood'),
    Chat(icon: CarbonIcons.satellite, title: 'Work'),
    Chat(icon: CarbonIcons.gas_station, title: 'Mechanics'),
    Chat(icon: CarbonIcons.keyboard, title: 'Programming'),
    Chat(icon: CarbonIcons.watson, title: 'Ideas'),
    Chat(icon: CarbonIcons.quadrant_plot, title: 'Stats'),
  ]; // Needs  to be retrieved from server
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(true);

    return Stack(
      children: [
        Column(
          children: [
            QuestionButton(
              onPressed: () => _showSnackbar(
                context: context,
                message: 'Tapped on bot',
              ),
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
                  chats: chats,
                ),
              ),
            ),
          ],
        ),
        AnimatedPositioned(
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
        ),
      ],
    );
  }

  void _showSnackbar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
