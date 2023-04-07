import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'label_statistics_cubit.dart';

class LabelStatistics extends StatelessWidget {
  final String timeOption;
  const LabelStatistics({required this.timeOption, Key? key}) : super(key: key);

  Widget _amount(
    BuildContext context,
    LabelStatisticsState state,
    IconData category,
  ) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(96),
      ),
      child: Text(
        '${state.labelStatistics(timeOption)[categoryIcons.indexOf(category)]}',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
            ),
      ),
    );
  }

  Widget _label(
    BuildContext context,
    LabelStatisticsState state,
    IconData category,
  ) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(
          96,
        ),
      ),
      child: Icon(
        category,
        size: 40,
      ),
    );
  }

  Widget _labels(BuildContext context, LabelStatisticsState state) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              for (final category in categoryIcons)
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    _label(context, state, category),
                    _amount(context, state, category),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabelStatisticsCubit, LabelStatisticsState>(
      builder: (context, state) {
        return Column(
          children: [
            _labels(context, state),
          ],
        );
      },
    );
  }
}
