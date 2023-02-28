import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/theme/theme_cubit.dart';
import '../../../theme/theme_scope.dart';

class AppearanceGroupHeaderSwitcher extends StatelessWidget {
  const AppearanceGroupHeaderSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return CupertinoSwitch(
          value: state.dateBubbleVisible,
          onChanged: (value) {
            ThemeScope.of(context).dateBubbleVisible = !state.dateBubbleVisible;
          },
          activeColor: Colors.green,
        );
      },
    );
  }
}
