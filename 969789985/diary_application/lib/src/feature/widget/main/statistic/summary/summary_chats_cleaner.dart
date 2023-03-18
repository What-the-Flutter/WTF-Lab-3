import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../../timeline/scope/timeline_scope.dart';
import 'summary_chats_cleaner_card.dart';

class SummaryChatsCleaner extends StatelessWidget {
  const SummaryChatsCleaner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (_, __) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height:
          TimelineScope.of(context).selectedChats().isEmpty ? 0.0 : 55.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: TimelineScope.of(context).selectedChats().length,
            itemBuilder: (_, index) {
              return SummaryChatsCleanerCard(
                chat: TimelineScope.of(context).selectedChats()[index],
              );
            },
          ),
        );
      },
    );
  }
}