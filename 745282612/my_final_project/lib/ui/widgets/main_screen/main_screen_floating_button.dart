import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

class MainScreenFloatingButton extends StatelessWidget {
  const MainScreenFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.colorLightYellow,
      foregroundColor: Colors.black,
      child: const Icon(Icons.add),
      onPressed: () {},
    );
  }
}
