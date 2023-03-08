import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/main/start_screen_cubit.dart';
import '../../cubit/timeline/timeline_cubit.dart';
import '../timeline/scope/timeline_scope.dart';
import 'scope/main_scope.dart';

class ClearFilter extends StatelessWidget {
  const ClearFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartScreenCubit, StartScreenState>(
      builder: (context, sState) {
        return BlocBuilder<TimelineCubit, TimelineState>(
          builder: (context, state) {
            return AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: state.map(
                defaultMode: (defaultMode) => defaultMode.isFiltered &&
                        StartScreenScope.of(context).state.pageIndex == 1
                    ? 1.0
                    : 0.0,
                filterMode: (filterMode) => 0.0,
              )!,
              child: IconButton(
                onPressed: () => TimelineScope.of(context).clearFilters(),
                icon: const Icon(Icons.filter_list_off),
              ),
            );
          },
        );
      },
    );
  }
}
