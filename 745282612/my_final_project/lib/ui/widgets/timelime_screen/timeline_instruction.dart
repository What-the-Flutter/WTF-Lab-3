import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class TimeLineInstruction extends StatelessWidget {
  const TimeLineInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<SettingCubit>().isLight();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        color: isLight ? AppColors.colorLisgtTurquoise : AppColors.colorLightGrey,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              S.of(context).timeline_empty,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
                color: AppColors.colorNormalGrey,
              ),
              S.of(context).timeline_empty_info,
            ),
          ],
        ),
      ),
    );
  }
}
