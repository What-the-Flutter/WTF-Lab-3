import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

class TravelScreenInstruction extends StatelessWidget {
  const TravelScreenInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        color: AppColors.colorLisgtTurquoise,
        height: 240,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              textAlign: TextAlign.center,
              'This is the page where you can track everything about "Travel"!',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: AppColors.colorLightGrey,
              ),
              'Add your first event to "Travel" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
            ),
          ],
        ),
      ),
    );
  }
}
