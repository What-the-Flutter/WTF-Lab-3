import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../filter_page/filter_page.dart';
import 'label_statistics/label_statistics.dart';
import 'label_statistics/label_statistics_cubit.dart';
import 'statistics_page_cubit.dart';
import 'summary_statistics/summary_statistics.dart';
import 'summary_statistics/summary_statistics_cubit.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  String _generateTime(String timeOption) {
    if (timeOption == 'Today') {
      return DateFormat('MMM dd, yyyy').format(DateTime.now());
    } else if (timeOption == 'Past 7 days') {
      return '${DateFormat('MMM dd, yyyy').format(DateTime.now().subtract(const Duration(days: 7)))} -  ${DateFormat('MMM dd, yyyy').format(DateTime.now())}';
    } else if (timeOption == 'Past 30 days') {
      return '${DateFormat('MMM dd, yyyy').format(DateTime.now().subtract(const Duration(days: 30)))} -  ${DateFormat('MMM dd, yyyy').format(DateTime.now())}';
    } else if (timeOption == 'This year') {
      return DateFormat('yyyy').format(DateTime.now());
    }
    throw Exception('Invalid time option');
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Statistics',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }

  Widget _timeOption(BuildContext context, StatisticsPageState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text(
                state.timeOption,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.deepPurple,
                    ),
              ),
              trailing: state.isShowingOptions
                  ? const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.deepPurple,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_down,
                    ),
              onTap: context.read<StatisticsPageCubit>().toggleShowingOptions,
            ),
          ),
          IconButton(
            onPressed: () async {
              final events = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FilterPage(
                    isOnlyPagesFiltered: true,
                  ),
                ),
              );
              context.read<LabelStatisticsCubit>().updateEvents(events);
              context.read<SummaryStatisticsCubit>().updateEvents(events);
            },
            icon: const Icon(
              Icons.filter_list,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeListTile(
    BuildContext context,
    StatisticsPageState state,
    int index,
  ) {
    return ListTile(
      title: Text(
        timeOptions[index],
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: state.timeOption == timeOptions[index]
                  ? Colors.deepPurple
                  : Theme.of(context).secondaryHeaderColor,
            ),
      ),
      subtitle: Text(
        _generateTime(timeOptions[index]),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: state.timeOption == timeOptions[index]
                  ? Colors.deepPurple
                  : Theme.of(context).disabledColor,
            ),
      ),
      onTap: () {
        context
            .read<StatisticsPageCubit>()
            .toggleShowingOptions(option: timeOptions[index]);
      },
    );
  }

  Widget _timeOptions(BuildContext context, StatisticsPageState state) {
    return Expanded(
      flex: state.isShowingOptions ? 2 : 0,
      child: Container(
        height: state.isShowingOptions ? 100 : 1,
        child: state.isShowingOptions
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: timeOptions.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) => Column(
                        children: [
                          _timeListTile(context, state, index),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _body(int index, BuildContext context, StatisticsPageState state) {
    if (index == 0) {
      return Expanded(
        child: LabelStatistics(
          timeOption: state.timeOption,
        ),
      );
    } else if (index == 1) {
      return Expanded(
        child: SummaryStatistics(
          timeOption: state.timeOption,
        ),
      );
    }
    throw Exception('Invalid index');
  }

  Widget _bottomNavigationBar(BuildContext context, StatisticsPageState state) {
    return BottomNavigationBar(
      currentIndex: state.selectedIndex,
      onTap: context.read<StatisticsPageCubit>().changeSelectedIndex,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.bubble_chart,
          ),
          label: 'Labels',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.insert_chart,
          ),
          label: 'Summary',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsPageCubit, StatisticsPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context),
          body: Column(
            children: [
              _timeOption(context, state),
              _timeOptions(context, state),
              _body(state.selectedIndex, context, state),
            ],
          ),
          bottomNavigationBar: _bottomNavigationBar(context, state),
        );
      },
    );
  }
}
