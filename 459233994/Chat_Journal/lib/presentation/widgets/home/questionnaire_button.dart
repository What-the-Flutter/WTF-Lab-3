import 'package:flutter/material.dart';

class QuestionnaireButton extends StatelessWidget {
  const QuestionnaireButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white,
        backgroundColor: const Color(0xFFE8FCC2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.psychology,
              color: Color(0xff545F66),
            ),
            Text(
              'Questionnaire bot',
              style: TextStyle(color: Color(0xff545F66)),
            ),
          ],
        ),
      ),
    );
  }
}