import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/strings.dart';
import '../../../../cubit/statistic/statistic_cubit.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../../../chatter/chatter_main/chatter_list_item/chatter_card.dart';
import '../../../chatter/scope/chatter_scope.dart';
import '../../../theme/theme_scope.dart';
import '../../../timeline/scope/timeline_scope.dart';
import '../graph/messages_graph.dart';
import '../statistic_scope.dart';
import '../summary/summary_chats_cleaner.dart';
import '../summary/summary_statistic.dart';
import '../summary_chat_selector_button.dart';

class SummaryBody extends StatelessWidget {
  const SummaryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: Insets.large),
          const Text(
            '',
            style: TextStyle(fontSize: FontsSize.normal),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.large),
          const _DateRangeSelector(),
          const SizedBox(height: Insets.medium),
          MessagesGraph(),
          const SizedBox(height: Insets.medium),
          Row(
            children: [
              const SummaryChatSelectorButton(),
            ],
          ),
          const SummaryChatsCleaner(),
          const SizedBox(height: Insets.large),
          const Text(
            'Most used chat',
            style: TextStyle(fontSize: FontsSize.large),
          ),
          ChatterScope.of(context).state.chats.isEmpty
              ? const Text(
            'Oops...\nChats list is empty',
            textAlign: TextAlign.center,
          )
              : ChatterCard(
            chat: StatisticScope.of(context).mostUsedChat(
              ChatterScope.of(context).state.chats,
              TimelineScope.of(context).state.defaultMessages,
            ),
            isActionsVisible: false,
          ),
          const SizedBox(height: Insets.medium),
          const SummaryStatistic(),
          const SizedBox(height: Insets.superDuperUltraMegaExtraLarge * 1.1),
        ],
      ),
    );
  }
}

class _DateRangeSelector extends StatelessWidget {
  const _DateRangeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return BlocBuilder<StatisticCubit, StatisticState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _DateRangeSelectorButton(
                      widgetText: 'Last week',
                      width:
                      width(context, MessageDateChartSelections.lastWeek),
                      height:
                      height(context, MessageDateChartSelections.lastWeek),
                      color:
                      color(context, MessageDateChartSelections.lastWeek),
                      callback: () {
                        StatisticScope.of(context).updateMessageDateSelection(
                          MessageDateChartSelections.lastWeek,
                        );
                      },
                    ),
                    const SizedBox(width: Insets.medium),
                    _DateRangeSelectorButton(
                      widgetText: 'Last Month',
                      width:
                      width(context, MessageDateChartSelections.lastMonth),
                      height:
                      height(context, MessageDateChartSelections.lastMonth),
                      color:
                      color(context, MessageDateChartSelections.lastMonth),
                      callback: () {
                        StatisticScope.of(context).updateMessageDateSelection(
                          MessageDateChartSelections.lastMonth,
                        );
                      },
                    ),
                    const SizedBox(width: Insets.medium),
                    _DateRangeSelectorButton(
                      widgetText: 'Six months',
                      width: width(
                          context, MessageDateChartSelections.lastSixMonth),
                      height: height(
                          context, MessageDateChartSelections.lastSixMonth),
                      color: color(
                          context, MessageDateChartSelections.lastSixMonth),
                      callback: () {
                        StatisticScope.of(context).updateMessageDateSelection(
                          MessageDateChartSelections.lastSixMonth,
                        );
                      },
                    ),
                    const SizedBox(width: Insets.medium),
                    _DateRangeSelectorButton(
                      widgetText: 'Last year',
                      width:
                      width(context, MessageDateChartSelections.lastYear),
                      height:
                      height(context, MessageDateChartSelections.lastYear),
                      color:
                      color(context, MessageDateChartSelections.lastYear),
                      callback: () {
                        StatisticScope.of(context).updateMessageDateSelection(
                          MessageDateChartSelections.lastYear,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  double width(BuildContext context, MessageDateChartSelections selection) {
    return StatisticScope.of(context).state.dateSelection == selection
        ? 140.0
        : 120.0;
  }

  double height(BuildContext context, MessageDateChartSelections selection) {
    return StatisticScope.of(context).state.dateSelection == selection
        ? 50.0
        : 40.0;
  }

  int color(BuildContext context, MessageDateChartSelections selection) {
    return StatisticScope.of(context).state.dateSelection == selection
        ? ThemeScope.of(context).state.primaryColor
        : ThemeScope.of(context).state.primaryItemColor;
  }
}

class _DateRangeSelectorButton extends StatelessWidget {
  final String widgetText;
  final double width;
  final double height;
  final int color;
  final VoidCallback callback;

  const _DateRangeSelectorButton({
    super.key,
    required this.widgetText,
    required this.width,
    required this.height,
    required this.color,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.medium),
        color: Color(color),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(Radii.medium),
        color: Color(color),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.medium),
          onTap: callback.call,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.medium),
            child: Center(
              child: Text(
                widgetText,
                style: const TextStyle(
                  fontSize: FontsSize.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
