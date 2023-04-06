import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../data/models/date_filter.dart';
import '../../data/models/event.dart';
import 'statistics_cubit.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage();

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  static final _formatter = DateFormat.yMMMMd('en_US');
  static final _totalColor = Colors.blue;
  static final _bookmarksColor = Colors.green;
  static final _labelsColor = Colors.red;
  static final _now = DateTime.now();

  final _cubit = GetIt.I<StatisticsCubit>();

  String _periodView({
    required DateTime from,
    required DateTime to,
  }) {
    return '${_formatter.format(from)} - ${_formatter.format(to)}';
  }

  Widget _dropDownButton({
    required DateFilter currentFilter,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: currentFilter,
        onChanged: (filter) {
          if (filter == null) return;

          _cubit.setFilter(filter);
        },
        items: const [
          DropdownMenuItem(
            child: Text('Today'),
            value: DateFilter.today,
          ),
          DropdownMenuItem(
            child: Text('Past 7 days'),
            value: DateFilter.days7,
          ),
          DropdownMenuItem(
            child: Text('Past 30 days'),
            value: DateFilter.days30,
          ),
          DropdownMenuItem(
            child: Text('This year'),
            value: DateFilter.thisYear,
          ),
        ],
      ),
    );
  }

  List<Event> _filteredEvents({
    required List<Event> sourceEvents,
    required DateFilter filter,
  }) {
    final DateTime startedDate;
    switch (filter) {
      case DateFilter.today:
        startedDate = DateTime(_now.year, _now.month, _now.day);
        break;
      case DateFilter.days7:
        final newDate = _now.subtract(const Duration(days: 7));
        startedDate = DateTime(newDate.year, newDate.month, newDate.day);
        break;
      case DateFilter.days30:
        final newDate = _now.subtract(const Duration(days: 30));
        startedDate = DateTime(newDate.year, newDate.month, newDate.day);
        break;
      case DateFilter.thisYear:
        startedDate = DateTime(_now.year);
        break;
    }

    return
        sourceEvents.where((e) => e.changeTime.isAfter(startedDate)).toList();
  }

  Widget _statisticsView({
    required int totalCount,
    required int bookmarksCount,
    required int labelsCount,
  }) {
    return Column(
      children: [
        Card(
          color: _totalColor,
          child: ListTile(
            title: Text(totalCount.toString()),
            subtitle: const Text('Total'),
          ),
        ),
        Card(
          color: _bookmarksColor,
          child: ListTile(
            title: Text(bookmarksCount.toString()),
            subtitle: const Text('Bookmarks'),
          ),
        ),
        Card(
          color: _labelsColor,
          child: ListTile(
            title: Text(labelsCount.toString()),
            subtitle: const Text('Labels'),
          ),
        ),
      ],
    );
  }

  Widget _pieChart({
    required int totalCount,
    required int bookmarksCount,
    required int labelsCount,
  }) {
    final sectionRadius = 60.0; 
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 100,
            sections: [
              PieChartSectionData(
                color: _totalColor,
                value: totalCount.toDouble(),
                title: '$totalCount',
                radius: sectionRadius,
              ),
              PieChartSectionData(
                color: _bookmarksColor,
                value: bookmarksCount.toDouble(),
                title: '$bookmarksCount',
                radius: sectionRadius,
              ),
              PieChartSectionData(
                color: _labelsColor,
                value: labelsCount.toDouble(),
                title: '$labelsCount',
                radius: sectionRadius,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        final filteredEvents = _filteredEvents(
          sourceEvents: state.events,
          filter: state.currentFilter,
        );

        final totalCount = filteredEvents.length;
        final bookmarksCount = 
            filteredEvents.where((e) => e.isFavorite).length;
        final labelsCount =
            filteredEvents.where((e) => e.categoryId != null).length;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Statistics'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dropDownButton(currentFilter: state.currentFilter),
                _statisticsView(
                  totalCount: totalCount,
                  bookmarksCount: bookmarksCount,
                  labelsCount: labelsCount,
                ),

                _pieChart(
                  totalCount: totalCount,
                  bookmarksCount: bookmarksCount,
                  labelsCount: labelsCount,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
