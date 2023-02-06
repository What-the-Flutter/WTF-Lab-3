import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_cubit.dart';

class BottomNavigationBarStatistics extends StatelessWidget {
  final int index;

  const BottomNavigationBarStatistics({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.stacked_bar_chart),
          label: S.of(context).summary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chair_alt),
          label: S.of(context).popular,
        ),
      ],
      onTap: context.read<StatisticsCubit>().changeBodyStatistics,
    );
  }
}
