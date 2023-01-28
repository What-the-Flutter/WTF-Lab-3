import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/event_message.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_screen_list_message.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_state.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/timeline_instruction.dart';

class TimelineBody extends StatelessWidget {
  const TimelineBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        final eventListReversed = state.filterList.reversed.toList();
        return eventListReversed.isEmpty
            ? const TimeLineInstruction()
            : ListView.builder(
                reverse: true,
                itemCount: eventListReversed.length,
                itemBuilder: (context, index) {
                  final event = eventListReversed[index];
                  return Column(
                    children: [
                      dateEvent(context, index, eventListReversed),
                      EventMessage(event: event),
                    ],
                  );
                },
              );
      },
    );
  }
}
