import 'package:flutter/material.dart';

import '/../data/constants/color_constants.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorConstants.themeColor,
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}