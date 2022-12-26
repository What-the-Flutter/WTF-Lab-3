import 'package:flutter/material.dart';

import '../widgets/home_screen/home_screen_chat_element.dart';
import '../widgets/home_screen/home_screen_question_btn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeScreenQuestionButton(),
        const Divider(),
        Expanded(
          child: HomeScreenChatElement(),
        ),
      ],
    );
  }
}
