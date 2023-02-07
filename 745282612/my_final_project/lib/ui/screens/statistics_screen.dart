import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/body.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/bottom_nav_bar.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_cubit.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_state.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).statistics,
              style: TextStyle(
                fontSize: context.read<SettingCubit>().state.textTheme.displayMedium!.fontSize,
              ),
            ),
          ),
          body: BodyStatistics(index: state.index),
          bottomNavigationBar: BottomNavigationBarStatistics(
            index: state.index,
          ),
        );
      },
    );
  }
}
