import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/colors.dart';
import '../../theme/themes.dart';
import '../pages/settings_page/settings_cubit.dart';

class QuestionnaireBotButton extends StatelessWidget {
  QuestionnaireBotButton({super.key});

  TextTheme textTheme(BuildContext context) {
    final fontSize = context.read<SettingsCubit>().state.fontSize;
    switch (fontSize) {
      case 1:
        return Themes.largeTextTheme;
      case -1:
        return Themes.smallTextTheme;
      default:
        return Themes.normalTextTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 25,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.watch<SettingsCubit>().state.isLightTheme
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
              color: context.watch<SettingsCubit>().state.isLightTheme
                  ? Colors.black
                  : Colors.white,
            ),
            const SizedBox(width: 20),
            Text(
              'Questionnaire bot',
              style: context.watch<SettingsCubit>().state.isLightTheme
                  ? textTheme(context).headline4!.copyWith(
                        color: Colors.black,
                      )
                  : textTheme(context).headline4!.copyWith(
                        color: Colors.white,
                      ),
            )
          ],
        ),
      ),
    );
  }
}
