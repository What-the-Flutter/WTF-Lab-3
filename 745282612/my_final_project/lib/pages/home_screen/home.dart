import 'package:flutter/material.dart';

import 'chat_view.dart';
import 'question_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const QuestionButton(),
        Expanded(
          child: ChatList(),
        ),
      ],
    );
  }
}
