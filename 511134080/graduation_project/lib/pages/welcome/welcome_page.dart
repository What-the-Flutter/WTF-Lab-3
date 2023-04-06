import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import '../main/main_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  Widget _animatedText(BuildContext context) {
    return AnimatedTextKit(
      totalRepeatCount: 1,
      pause: const Duration(
        milliseconds: 0,
      ),
      onFinished: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              context: context,
            ),
          ),
        );
      },
      animatedTexts: [
        TyperAnimatedText(
          'Chat Journal',
          textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 48,
                color: Colors.grey[700],
                fontWeight: FontWeight.w800,
                letterSpacing: 4,
              ),
          speed: const Duration(
            milliseconds: 300,
          ),
        ),
      ],
    );
  }

  Widget _welcomeAnimation(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 128,
          ),
          _animatedText(context),
          const SizedBox(
            height: 64,
          ),
          Lottie.asset(
            homeAnimationLottie,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _welcomeAnimation(context),
      );
}
