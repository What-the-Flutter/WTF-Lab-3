import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/datasource/source/activity_source.dart';
import '../../../../core/data/repository/statistic/statistic_repository.dart';
import '../../../cubit/statistic/statistic_cubit.dart';

class StatisticScope extends StatelessWidget {
  final Widget child;

  const StatisticScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticCubit(
        repository: StatisticRepository(
          provider: RepositoryProvider.of<ActivitySource>(context),
        ),
      ),
      child: child,
    );
  }

  static StatisticCubit of(BuildContext context) =>
      context.read<StatisticCubit>();
}
