import 'package:flutter/material.dart';

import 'package:my_final_project/ui/widgets/home_screen/home_screen_chat_element.dart';
import 'package:my_final_project/ui/widgets/home_screen/home_screen_question_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static _HomeScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeScreenState>()!;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeScreenQuestionButton(),
        const Divider(),
        const Expanded(
          child: HomeScreenChatElement(),
        ),
      ],
    );
  }
}
