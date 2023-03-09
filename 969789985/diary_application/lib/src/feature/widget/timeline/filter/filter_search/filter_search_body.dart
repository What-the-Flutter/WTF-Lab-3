import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../message/timeline_message_list.dart';

class FilterSearchBody extends StatelessWidget {
  const FilterSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return TimelineMessageList(
          messages: state.mapOrNull(
            filterMode: (filterMode) => filterMode.messages,
          )!,
          isFilter: true,
        );
      },
    );
  }
}
