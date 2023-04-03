import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

Widget searchingAnimation = SingleChildScrollView(
  child: Center(
    child: Lottie.asset(
      searchingAnimationLottie,
    ),
  ),
);
