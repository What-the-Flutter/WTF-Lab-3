import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/themes.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../theme/theme_scope.dart';

class ColorsSelector extends StatelessWidget {
  const ColorsSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          children: ThemeScope.of(context).state.isDarkMode
              ? DarkPossibleColors.values
                  .map(
                    (possibleColors) => IconButton(
                      onPressed: () {
                        ThemeScope.of(context).setColors(
                          possibleColors.colors[0],
                          possibleColors.colors[1],
                        );
                        Navigator.pop(context);
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(
                          right: Insets.appConstantSmall + Insets.small,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: Radii.large,
                              backgroundColor: Color(possibleColors.colors[0]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Insets.extraLarge),
                              child: CircleAvatar(
                                maxRadius: Radii.large,
                                backgroundColor:
                                    Color(possibleColors.colors[1]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
              : LightPossibleColors.values
                  .map(
                    (possibleColors) => IconButton(
                      onPressed: () {
                        ThemeScope.of(context).setColors(
                          possibleColors.colors[0],
                          possibleColors.colors[1],
                        );
                        Navigator.pop(context);
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(
                          right: Insets.appConstantSmall + Insets.small,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: Radii.large,
                              backgroundColor: Color(possibleColors.colors[0]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Insets.extraLarge),
                              child: CircleAvatar(
                                maxRadius: Radii.large,
                                backgroundColor:
                                    Color(possibleColors.colors[1]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
        );
      },
    );
  }
}
