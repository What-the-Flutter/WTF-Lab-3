import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_theme/inherited_theme.dart';
import 'statistics_cubit.dart';
import 'statistics_state.dart';

class Statistics extends StatefulWidget {
  final String title = 'Statistics';

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late int touchedIndex;

  @override
  void initState() {
    super.initState();
    ReadContext(context).read<StatisticsCubit>().loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: InheritedAppTheme.of(context)!.themeData.keyColor,
            ),
          ),
        ),
        backgroundColor: InheritedAppTheme.of(context)!.themeData.themeColor,
      ),
      body: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if (state.isLoaded) {
            return Column(
              children: <Widget>[
                _statInfo(),
                _chart(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      backgroundColor: InheritedAppTheme.of(context)!.themeData.backgroundColor,
    );
  }

  Widget _statInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    color: Colors.green,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            ReadContext(context)
                                .read<StatisticsCubit>()
                                .getTotalAmountOfEvents()
                                .toString(),
                          ),
                          const Text('Total'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    color: Colors.yellow,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            ReadContext(context)
                                .read<StatisticsCubit>()
                                .getAmountOfFavorites()
                                .toString(),
                          ),
                          const Text('Favorites'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    color: Colors.red,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            ReadContext(context)
                                .read<StatisticsCubit>()
                                .getAmountOfDone()
                                .toString(),
                          ),
                          const Text('Done'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chart() {
    return FutureBuilder(
      future: _getListData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final chartData = snapshot.data;
          return AspectRatio(
            aspectRatio: 0.8,
            child: BarChart(
              BarChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5,
                  ),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: chartData?.length.toDouble(),
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval: 5,
                        showTitles: true,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval: 10,
                        showTitles: true,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: chartData),
            ),
          );
        }
      },
    );
  }

  Future<List<BarChartGroupData>> _getListData() async {
    var mainItems = await ReadContext(context)
        .read<StatisticsCubit>()
        .getMapForSummaryChart();
    var bufItems = mainItems.entries.toList().reversed;
    mainItems = Map.fromEntries(bufItems);
    final chartData = mainItems.entries
        .map(
          (entry) => BarChartGroupData(
            x: entry.key + 1,
            barRods: [
              BarChartRodData(
                rodStackItems: [
                  BarChartRodStackItem(
                      0, mainItems[entry.key]![2].toDouble(), Colors.yellow),
                  BarChartRodStackItem(mainItems[entry.key]![2].toDouble(),
                      mainItems[entry.key]![1].toDouble(), Colors.red),
                  BarChartRodStackItem(mainItems[entry.key]![1].toDouble(),
                      mainItems[entry.key]![0].toDouble(), Colors.green)
                ],
                color: Colors.transparent,
                toY: 100,
                width: 8,
              )
            ],
          ),
        )
        .toList();
    return chartData;
  }
}
