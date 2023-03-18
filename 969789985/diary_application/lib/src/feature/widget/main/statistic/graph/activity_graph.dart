import 'dart:math';
import 'package:collection/collection.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/domain/models/local/activity/activity_model.dart';
import '../../../../../core/util/extension/datetime_extension.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/statistic/statistic_cubit.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../theme/theme_scope.dart';

class ActivityGraph extends StatelessWidget {
  ActivityGraph({super.key});

  //TODO: for example only :)))))))))))))))))))))
  final dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //TODO: for example only :)))))))))))))))))))))
    final list = List<ActivityModel>.generate(
      7,
          (index) => ActivityModel(
        date: dateTime.copyWith(day: dateTime.day - index),
        spentTime: index == 6 ? 180 : (index + 1) * 60,
      ),
    );

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, tState) {
        return BlocBuilder<StatisticCubit, StatisticState>(
          builder: (context, state) {
            return Column(
              children: [
                Center(
                  child: state.activities.isEmpty
                      ? const Text(
                    'No data...',
                    style: TextStyle(
                      fontSize: FontsSize.large,
                    ),
                  )
                      : SfCartesianChart(
                    margin: EdgeInsets.zero,
                    tooltipBehavior: _tooltipBehavior(context),
                    plotAreaBorderWidth: Insets.none,
                    primaryXAxis: CategoryAxis(
                      majorGridLines:
                      const MajorGridLines(width: Insets.none),
                      axisLine: const AxisLine(width: Insets.none),
                      majorTickLines:
                      const MajorTickLines(size: Insets.none),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: list
                          .map(
                            (activity) =>
                        (activity.spentTime / 60).floor() as int,
                      )
                          .toList()
                          .reduce(max)
                          .toDouble(),
                      //state.yMax.toDouble() + 3,
                      isVisible: false,
                      majorGridLines:
                      const MajorGridLines(width: Insets.none),
                      axisLine: const AxisLine(width: Insets.none),
                    ),
                    series: <ChartSeries<ActivityModel, String>>[
                      ColumnSeries(
                        width: 0.8,
                        enableTooltip: true,
                        dataSource: list.sorted(
                              (a, b) => a.date.compareTo(b.date),
                        ),
                        //state.activities.toList(),
                        xValueMapper: (activity, _) =>
                            activity.date.dayOfWeekend(),
                        yValueMapper: (activity, _) =>
                            (activity.spentTime / 60).floor(),
                        color: Color(
                            ThemeScope.of(context).state.primaryColor),
                        borderRadius: BorderRadius.circular(Radii.medium),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  TooltipBehavior _tooltipBehavior(BuildContext context) {
    return TooltipBehavior(
      elevation: 0,
      opacity: 0.0,
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
      color: Colors.transparent,
      header: '',
      builder: (data, _, __, ___, ____) {
        final time = ((data as ActivityModel).spentTime / 60).floor();

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.medium),
            color: Color(ThemeScope.of(context).state.primaryItemColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.medium,
              vertical: Insets.small,
            ),
            child: Text(
              time == 1 ? '$time minute' : '$time minutes',
            ),
          ),
        );
      },
    );
  }
}
