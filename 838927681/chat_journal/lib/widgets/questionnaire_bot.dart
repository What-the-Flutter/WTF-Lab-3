import 'package:flutter/material.dart';
import '../theme/colors.dart';

class QuestionnaireBotButton extends StatelessWidget {
  const QuestionnaireBotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 25,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ChatJournalColors.questionnaireBotColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.smart_toy,
              color: Colors.black,
            ),
            SizedBox(width: 20),
            Text(
              'Questionnaire bot',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
