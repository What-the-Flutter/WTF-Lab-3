import 'package:flutter/material.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/custom_icons/custom_icons.dart';

class HomeScreenQuestionButton extends StatelessWidget {
  const HomeScreenQuestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              theme ? AppColors.colorLisgtTurquoise : AppColors.colorLightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CustomIcons.robot,
                color: theme ? Colors.black : Colors.white,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                S.of(context).questionnaire,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
