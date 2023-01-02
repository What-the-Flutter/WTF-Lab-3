import 'package:flutter/material.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class Instruction extends StatelessWidget {
  final String title;

  const Instruction({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return EventScreenInstruction(
            heightContrainer: 380,
            headerSize: 40,
            contentSize: 20,
            title: title,
          );
        } else {
          return EventScreenInstruction(
            heightContrainer: 240,
            headerSize: 17,
            contentSize: 15,
            title: title,
          );
        }
      },
    );
  }
}

class EventScreenInstruction extends StatelessWidget {
  final String title;
  final double heightContrainer;
  final double headerSize;
  final double contentSize;

  const EventScreenInstruction({
    super.key,
    required this.heightContrainer,
    required this.headerSize,
    required this.contentSize,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        color: AppColors.colorLisgtTurquoise,
        height: heightContrainer,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              S.of(context).title_instruction(title),
              style: TextStyle(
                fontSize: headerSize,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: contentSize,
                color: AppColors.colorNormalGrey,
              ),
              S.of(context).body_instruction(title),
            ),
          ],
        ),
      ),
    );
  }
}
