import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/custom_icons/custom_icons.dart';

class HomeScreenQuestionButton extends StatelessWidget {
  const HomeScreenQuestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.colorLisgtTurquoise,
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
              const Icon(
                CustomIcons.robot,
                color: Colors.black,
              ),
              const SizedBox(
                width: 25,
              ),
              const Text(
                'Questionnarie bot',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
