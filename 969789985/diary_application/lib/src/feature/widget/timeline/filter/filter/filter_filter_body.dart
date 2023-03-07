import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../message/timeline_message_list.dart';
import 'filter_selectors.dart';

class FilterFilterBody extends StatelessWidget {
  const FilterFilterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Column(
          children: [
            const FilterDateSelector(),
            const SizedBox(height: Insets.large),
            const FilterImageOnlySelector(),
            const SizedBox(height: Insets.medium),
            const FilterAudioOnlySelector(),
            const SizedBox(height: Insets.medium),
            Expanded(
              child: TimelineMessageList(
                isFilter: true,
                messages: state.mapOrNull(
                  filterMode: (filterMode) => filterMode.messages,
                )!,
              ),
            ),
          ],
        );
      },
    );
  }
}
