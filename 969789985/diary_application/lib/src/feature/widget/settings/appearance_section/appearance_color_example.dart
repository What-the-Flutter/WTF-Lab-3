import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/theme/theme_cubit.dart';
import '../../../../core/util/resources/dimensions.dart';

class AppearanceColorExample extends StatelessWidget {
  const AppearanceColorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              maxRadius: Radii.large,
              backgroundColor: Color(state.primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Insets.extraLarge),
              child: CircleAvatar(
                maxRadius: Radii.large,
                backgroundColor: Color(state.primaryItemColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
