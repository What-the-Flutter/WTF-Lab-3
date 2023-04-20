import 'package:flutter/material.dart';

import '../app_theme/inherited_theme.dart';

class QuestionnaireButton extends StatelessWidget {
  const QuestionnaireButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: InheritedAppTheme.of(context)!.themeData.backgroundColor,
        backgroundColor:
            InheritedAppTheme.of(context)!.themeData.auxiliaryColor,
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
          children: <Widget>[
            Icon(
              Icons.psychology,
              color: InheritedAppTheme.of(context)!.themeData.iconColor,
            ),
            Text(
              'Questionnaire Bot',
              style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
