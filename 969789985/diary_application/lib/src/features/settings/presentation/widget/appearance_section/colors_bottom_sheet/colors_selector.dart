import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/themes/cubit/theme_cubit.dart';
import '../../../../../../common/themes/themes/themes.dart';
import '../../../../../../common/themes/widget/theme_scope.dart';
import '../../../../../../common/values/dimensions.dart';

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
          children: [
            for (final colors in possibleColors)
              IconButton(
                  onPressed: () {
                    ThemeScope.of(context).setColors(colors[0], colors[1]);
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
                          backgroundColor: Color(colors[0]),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: Insets.extraLarge),
                          child: CircleAvatar(
                            maxRadius: Radii.large,
                            backgroundColor: Color(colors[1]),
                          ),
                        ),
                      ],
                    ),
                  )),
          ],
        );
      },
    );
  }
}
