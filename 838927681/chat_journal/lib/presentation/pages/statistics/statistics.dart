import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/statistics_title.dart';
import '../../../domain/entities/chart_data.dart';
import 'statistics_cubit.dart';
import 'statistics_state.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Statistics',
            ),
            centerTitle: true,
          ),
          body: _statisticsBody(context, state),
        );
      },
    );
  }

  Widget _statisticsBody(BuildContext context, StatisticsState state) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _dropdownButton(context, state),
          ..._info(context, state),
          _chart(context, state),
        ],
      ),
    );
  }

  Widget _dropdownButton(BuildContext context, StatisticsState state) {
    return DropdownButton<String>(
      value: state.period,
      items: [
        DropdownMenuItem<String>(
          value: StatisticsTitle.today,
          child: _menuItem(StatisticsTitle.today),
        ),
        DropdownMenuItem<String>(
          child: _menuItem(StatisticsTitle.week),
          value: StatisticsTitle.week,
        ),
        DropdownMenuItem(
          child: _menuItem(StatisticsTitle.month),
          value: StatisticsTitle.month,
        ),
        DropdownMenuItem(
          child: _menuItem(StatisticsTitle.year),
          value: StatisticsTitle.year,
        ),
      ],
      onChanged: context.read<StatisticsCubit>().changePeriod,
    );
  }

  Widget _menuItem(String value) {
    return Text(value);
  }

  List<Widget> _info(BuildContext context, StatisticsState state) {
    return [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _infoElement(
                color: Colors.lightBlue,
                count: state.totalList.length,
                category: 'Total'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: _infoElement(
                color: Colors.lightGreen,
                count: state.favoritesList.length,
                category: 'Favorites'),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      _infoElement(
          color: Colors.yellow,
          count: state.labelList.length,
          category: 'Label'),
    ];
  }

  Widget _infoElement(
      {required Color color, required int count, required String category}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [Text(count.toString()), Text(category)],
      ),
    );
  }

  Widget _chart(BuildContext context, StatisticsState state) {
    context.read<StatisticsCubit>().getStatisticsData();
    final state = context.watch<StatisticsCubit>().state;
    return Container(
      padding: const EdgeInsets.all(10),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: state.chartDataList,
            xValueMapper: (event, context) => event.dateX,
            yValueMapper: (event, context) => event.totalY,
            color: Colors.lightBlue,
          ),
          ColumnSeries<ChartData, String>(
            dataSource: state.chartDataList,
            xValueMapper: (event, context) => event.dateX,
            yValueMapper: (event, context) => event.favoritesY,
            color: Colors.lightGreen,
          ),
          ColumnSeries<ChartData, String>(
            dataSource: state.chartDataList,
            xValueMapper: (event, context) => event.dateX,
            yValueMapper: (event, context) => event.labelY,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
