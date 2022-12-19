import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class QuestionButton extends StatelessWidget {
  final Function onPressed;
  const QuestionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                CarbonIcons.bot,
                color: Colors.black,
              ),
              SizedBox(width: 20),
              Text(
                'Questionnarie bot',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
