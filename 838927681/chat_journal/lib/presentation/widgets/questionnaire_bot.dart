import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/colors.dart';
import '../../theme/fonts.dart';
import '../../theme/theme_cubit.dart';

class QuestionnaireBotButton extends StatelessWidget {
  QuestionnaireBotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 25,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: BlocProvider.of<ThemeCubit>(context).isLight()
              ? ChatJournalColors.lightGreen
              : ChatJournalColors.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smart_toy,
              color: BlocProvider.of<ThemeCubit>(context).isLight()
                  ? Colors.black
                  : Colors.white,
            ),
            const SizedBox(width: 20),
            Text(
              'Questionnaire bot',
              style: BlocProvider.of<ThemeCubit>(context).isLight()
                  ? Fonts.questionnaireBotLightFont
                  : Fonts.questionnaireBotDarkFont,
            )
          ],
        ),
      ),
    );
  }
}
