import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/repository/theme/theme_repository.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/typedefs.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../theme/theme_scope.dart';

class AppearanceMessageAlignment extends StatelessWidget {
  const AppearanceMessageAlignment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AnimatedChip(
                text: 'Left',
                action: () => ThemeScope.of(context).messageAlignment =
                    BubbleAlignments.start,
                width: _chipWidth(context, BubbleAlignments.start),
                height: _chipHeight(context, BubbleAlignments.start),
                color: _chipColor(context, BubbleAlignments.start),
              ),
              const SizedBox(width: Insets.large),
              _AnimatedChip(
                text: 'Center',
                action: () => ThemeScope.of(context).messageAlignment =
                    BubbleAlignments.center,
                width: _chipWidth(context, BubbleAlignments.center),
                height: _chipHeight(context, BubbleAlignments.center),
                color: _chipColor(context, BubbleAlignments.center),
              ),
              const SizedBox(width: Insets.large),
              _AnimatedChip(
                text: 'Right',
                action: () => ThemeScope.of(context).messageAlignment =
                    BubbleAlignments.end,
                width: _chipWidth(context, BubbleAlignments.end),
                height: _chipHeight(context, BubbleAlignments.end),
                color: _chipColor(context, BubbleAlignments.end),
              ),
            ],
          ),
        );
      },
    );
  }

  double _chipWidth(BuildContext context, BubbleAlignments alignment) =>
      ThemeScope.of(context).state.messageAlignment == alignment.alignment
          ? 130.0
          : 100.0;

  double _chipHeight(BuildContext context, BubbleAlignments alignment) =>
      ThemeScope.of(context).state.messageAlignment == alignment.alignment
          ? 60.0
          : 50.0;

  int _chipColor(BuildContext context, BubbleAlignments alignment) =>
      ThemeScope.of(context).state.messageAlignment == alignment.alignment
          ? ThemeScope.of(context).state.primaryColor
          : ThemeScope.of(context).state.primaryItemColor;
}

class _AnimatedChip extends StatelessWidget {
  final String text;
  final Callback action;
  final double width;
  final double height;
  final int color;

  const _AnimatedChip({
    super.key,
    required this.text,
    required this.action,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: width,
      height: height,
      curve: Curves.decelerate,
      child: Material(
        borderRadius: BorderRadius.circular(Radii.appConstantSmall),
        color: Color(color),
        child: InkWell(
          onTap: action.call,
          borderRadius: BorderRadius.circular(Radii.appConstantSmall),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Insets.medium,
              horizontal: Insets.large,
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: FontsSize.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
