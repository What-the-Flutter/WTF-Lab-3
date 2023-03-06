import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/colors.dart';
import '../pages/settings_page/settings_cubit.dart';

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
          backgroundColor: BlocProvider.of<SettingsCubit>(context).isLight()
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
              color: BlocProvider.of<SettingsCubit>(context).isLight()
                  ? Colors.black
                  : Colors.white,
            ),
            const SizedBox(width: 20),
            Text(
              'Questionnaire bot',
              style: BlocProvider.of<SettingsCubit>(context).isLight()
                  ? context
                      .watch<SettingsCubit>()
                      .state
                      .fontSize
                      .headline4!
                      .copyWith(
                        color: Colors.black,
                      )
                  : context
                      .watch<SettingsCubit>()
                      .state
                      .fontSize
                      .headline4!
                      .copyWith(
                        color: Colors.white,
                      ),
            )
          ],
        ),
      ),
    );
  }
}
