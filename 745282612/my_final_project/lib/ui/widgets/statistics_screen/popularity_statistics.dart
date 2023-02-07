import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_cubit.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_state.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:pie_chart/pie_chart.dart';

class PopularStatistics extends StatefulWidget {
  const PopularStatistics({super.key});

  @override
  State<PopularStatistics> createState() => _PopularStatisticsState();
}

class _PopularStatisticsState extends State<PopularStatistics> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<StatisticsCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _instruction(context),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _pieChartPopular(context, state),
          ),
        ],
      ),
    );
  }
}

Widget _pieChartPopular(BuildContext context, StatisticsState state) {
  if (state.mapPopular.isEmpty) {
    context.read<StatisticsCubit>().changeMapPopular();
    return const CircularProgressIndicator();
  }
  return Center(
    child: PieChart(
      dataMap: state.mapPopular,
      chartRadius: MediaQuery.of(context).size.width / 2,
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesInPercentage: true,
      ),
      legendOptions: const LegendOptions(
        legendPosition: LegendPosition.bottom,
      ),
    ),
  );
}

Widget _instruction(BuildContext context) {
  final isLight = context.read<SettingCubit>().isLight();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
    child: Container(
      color: isLight ? AppColors.colorLisgtTurquoise : AppColors.colorLightGrey,
      height: 105,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Text(
        textAlign: TextAlign.center,
        S.of(context).popular_instruction,
        style: TextStyle(
          fontSize: context.read<SettingCubit>().state.textTheme.bodyMedium!.fontSize,
        ),
      ),
    ),
  );
}
