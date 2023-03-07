import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/timeline/timeline_cubit.dart';
import 'filter/filter_filter_body.dart';
import 'filter_chatter/filter_chatter_body.dart';
import 'filter_search/filter_search_body.dart';
import 'filter_search_field.dart';
import 'filter_tags/filter_tags_body.dart';
import 'filter_way_selector.dart';

class FilterBody extends StatelessWidget {
  const FilterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Column(
          children: [
            const FilterSearchField(),
            const SizedBox(height: Insets.large),
            const FilterWaySelector(),
            const SizedBox(height: Insets.large),
            const Expanded(
              child: _BodySelector(),
            ),
          ],
        );
      },
    );
  }
}

class _BodySelector extends StatelessWidget {
  const _BodySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.5, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
          child: Container(
            key: ValueKey<String>(
              state.map(
                defaultMode: (defaultMode) => '',
                filterMode: (filterMode) => filterMode.filterWay.toString(),
              )!,
            ),
            child: state.map(
              defaultMode: (defaultMode) => const Text('Error'),
              filterMode: (filterMode) {
                switch (filterMode.filterWay) {
                  case 0:
                    return const FilterChatterBody();
                  case 1:
                    return const FilterTagsBody();
                  case 2:
                    return const FilterFilterBody();
                  case 3:
                    return const FilterSearchBody();
                  default:
                    return const Text('Error');
                }
              },
            ),
          ),
        );
      },
    );
  }
}
