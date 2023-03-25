import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme/app_theme_cubit.dart';

class QuestionnaireButton extends StatelessWidget {
  const QuestionnaireButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: ReadContext(context)
            .read<AppThemeCubit>()
            .state
            .customTheme
            .backgroundColor,
        backgroundColor: ReadContext(context)
            .read<AppThemeCubit>()
            .state
            .customTheme
            .auxiliaryColor,
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
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .iconColor,
            ),
            Text(
              'Questionnaire Bot',
              style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
