import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme/inherited_app_theme.dart';
import '../app_theme/theme_notifier.dart';



class QuestionnaireButton extends StatelessWidget {
  const QuestionnaireButton({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor:
                InheritedAppTheme.of(context)?.getTheme.backgroundColor,
            backgroundColor:
                InheritedAppTheme.of(context)?.getTheme.auxiliaryColor,
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
                  color: InheritedAppTheme.of(context)?.getTheme.iconColor,
                ),
                Text(
                  'Questionnaire Bot',
                  style: TextStyle(
                    color: InheritedAppTheme.of(context)?.getTheme.textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
