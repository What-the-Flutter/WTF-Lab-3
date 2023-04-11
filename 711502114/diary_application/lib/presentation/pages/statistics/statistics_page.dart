import 'package:diary_application/domain/models/category.dart';
import 'package:diary_application/domain/models/chart_data.dart';
import 'package:diary_application/presentation/widgets/labels/category_icon.dart';
import 'package:diary_application/presentation/widgets/summary/summary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'statistics_cubit.dart';
import 'statistics_state.dart';

class StatisticsPage extends StatelessWidget {
  static const Color color1 = Colors.deepOrange;
  static const Color color2 = Colors.blue;
  static const Color color3 = Colors.deepPurple;

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(local?.statistics ?? ''),
              bottom: TabBar(
                tabs: [
                  Tab(text: local?.summary),
                  Tab(text: local?.labels),
                ],
              ),
              centerTitle: true,
            ),
            body: TabBarView(
              children: [
                _statisticsPage(context, state),
                _labelsPage(context, context.read<StatisticsCubit>()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statisticsPage(BuildContext context, StatisticsState state) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _dropPeriodList(context, state),
          const SizedBox(height: 10),
          ..._infoBlocs(context, state),
          const SizedBox(height: 10),
          Expanded(child: _showGraphics(context, state)),
        ],
      ),
    );
  }

  Widget _dropPeriodList(BuildContext context, StatisticsState state) {
    final local = AppLocalizations.of(context);
    return SizedBox(
      width: 250,
      child: DropdownButton<String>(
        alignment: AlignmentDirectional.center,
        value: state.period.toString(),
        items: [
          DropdownMenuItem<String>(
            alignment: AlignmentDirectional.center,
            child: Text(local?.today ?? ''),
            value: StatisticsPeriodMode.today.toString(),
          ),
          DropdownMenuItem<String>(
            alignment: AlignmentDirectional.center,
            child: Text(local?.thisWeek ?? ''),
            value: StatisticsPeriodMode.thisWeek.toString(),
          ),
          DropdownMenuItem(
            alignment: AlignmentDirectional.center,
            child: Text(local?.thisMonth ?? ''),
            value: StatisticsPeriodMode.thisMonth.toString(),
          ),
          DropdownMenuItem(
            alignment: AlignmentDirectional.center,
            child: Text(local?.thisYear ?? ''),
            value: StatisticsPeriodMode.thisYear.toString(),
          ),
        ],
        onChanged: context.read<StatisticsCubit>().changePeriod,
      ),
    );
  }

  List<Widget> _infoBlocs(BuildContext context, StatisticsState state) {
    final local = AppLocalizations.of(context);
    return [
      SummaryContainer(
        backgroundColor: color1,
        count: state.total.length,
        category: local?.total ?? '',
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SummaryContainer(
              backgroundColor: color2,
              count: state.favorites.length,
              category: local?.favorites ?? '',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SummaryContainer(
              backgroundColor: color3,
              count: state.labels.length,
              category: local?.labels ?? '',
            ),
          ),
        ],
      ),
    ];
  }

  Widget _showGraphics(BuildContext context, StatisticsState state) {
    context.read<StatisticsCubit>().getStatistics();
    final state = context.watch<StatisticsCubit>().state;
    return Container(
      padding: const EdgeInsets.all(15),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: state.chartDataList,
            xValueMapper: (chart, _) => chart.dataX,
            yValueMapper: (chart, _) => chart.totalY,
            color: color1,
          ),
          ColumnSeries<ChartData, String>(
            dataSource: state.chartDataList,
            xValueMapper: (chart, _) => chart.dataX,
            yValueMapper: (chart, _) => chart.favoritesY,
            color: color2,
          ),
          ColumnSeries<ChartData, String>(
            dataSource: state.chartDataList,
            xValueMapper: (chart, _) => chart.dataX,
            yValueMapper: (chart, _) => chart.labelY,
            color: color3,
          ),
        ],
      ),
    );
  }

  Widget _labelsPage(BuildContext context, StatisticsCubit cubit) {
    final categories = Category.list.sublist(1);
    final events = cubit.getCategoryEvents();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _dropPeriodList(context, cubit.state),
          const SizedBox(height: 30),
          GridView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryIcon(
                child: categories[index].icon,
                title: categories[index].title,
                count: events
                    .where((e) => e.category?.title == categories[index].title)
                    .length,
              );
            },
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          ),
        ],
      ),
    );
  }
}
