import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/statistic/statistic_cubit.dart';
import '../../../../cubit/theme/theme_cubit.dart';
import '../graph/activity_graph.dart';
import '../statistic_scope.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, tState) {
        return BlocBuilder<StatisticCubit, StatisticState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: Insets.medium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${StatisticScope.of(context).averageOfMinutes()}',
                      style: const TextStyle(
                        fontSize: FontsSize.extraLarge * 1.5,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: Insets.medium,
                      ),
                      child: Text(
                        'm',
                        style: TextStyle(fontSize: FontsSize.normal),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Daily average',
                  style: TextStyle(
                    fontSize: FontsSize.large,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                Text(
                  //TODO(dev): ff
                  'fff',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontsSize.normal,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: Insets.large),
                ActivityGraph(),
              ],
            );
          },
        );
      },
    );
  }
}
