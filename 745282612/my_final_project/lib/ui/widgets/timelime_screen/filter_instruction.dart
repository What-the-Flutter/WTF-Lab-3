import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class FilterInstruction extends StatelessWidget {
  final String instructionText;

  const FilterInstruction({
    super.key,
    required this.instructionText,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = context.read<SettingCubit>().isLight();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        color: isLight ? AppColors.colorLisgtTurquoise : AppColors.colorLightGrey,
        height: 105,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Text(
          textAlign: TextAlign.center,
          S.of(context).filter_info(instructionText),
          style: TextStyle(
            fontSize: context.read<SettingCubit>().state.textTheme.bodyText1!.fontSize,
          ),
        ),
      ),
    );
  }
}
