import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/domain/models/local/message/message_model.dart';
import '../../../../../core/util/extension/datetime_extension.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/strings.dart';
import '../../../../cubit/statistic/statistic_cubit.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../theme/theme_scope.dart';
import '../statistic_scope.dart';

class MessagesGraph extends StatelessWidget {
  MessagesGraph({super.key});

  //TODO: only for chart example :))
  final messages = <MessageModel>[
    MessageModel(),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 1),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 1),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 2),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 3),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 3),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 3),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 7),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 30),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 180),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 180),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 180),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 360),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 360),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 360),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 360),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 270),
    ),
    MessageModel(
      sendDate: DateTime.now().copyWith(day: DateTime.now().day - 360),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return BlocBuilder<StatisticCubit, StatisticState>(
          builder: (context, state) {
            return Column(
              children: [
                Center(
                  child: SfCartesianChart(
                    margin: EdgeInsets.zero,
                    tooltipBehavior: _tooltipBehavior(context),
                    plotAreaBorderWidth: Insets.none,
                    primaryXAxis: DateTimeAxis(
                      intervalType: state.dateSelection ==
                          MessageDateChartSelections.lastYear ||
                          state.dateSelection ==
                              MessageDateChartSelections.lastSixMonth
                          ? DateTimeIntervalType.months
                          : DateTimeIntervalType.days,
                      minimum: state.datesRange.first,
                      maximum: state.datesRange.last,
                      isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(

                    ),
                    series: <ChartSeries<MessageModel, DateTime>>[
                      AreaSeries(
                        color: Color(ThemeScope.of(context).state.primaryColor),
                        enableTooltip: true,
                        dataSource: messages.sorted(
                              (a, b) => a.sendDate.compareTo(b.sendDate),
                        ),
                        /*TimelineScope.of(context)
                            .state
                            .defaultMessages
                            .toList(),*/
                        xValueMapper: (message, _) => StatisticScope.of(context)
                            .messagesGraphXAxis(message),
                        yValueMapper: (
                            message,
                            _,
                            ) => //TimelineScope.of(context).state.defaultMessages
                        StatisticScope.of(context).messagesGraphYAxis(
                          messages.toIList(),
                          message,
                        ),
                        markerSettings: const MarkerSettings(isVisible: true),
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
        final message = data as MessageModel;

        final count = StatisticScope.of(context).messagesGraphYAxis(
          messages.toIList(),
          message,
        );

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
              '${message.sendDate.dateYMMMDFormat()}\nMessages: $count',
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
