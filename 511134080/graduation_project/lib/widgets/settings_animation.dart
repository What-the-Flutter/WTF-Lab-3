import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

Widget settingsAnimation = SingleChildScrollView(
  child: Center(
    child: Lottie.asset(
      settingsAnimationLottie,
    ),
  ),
);
