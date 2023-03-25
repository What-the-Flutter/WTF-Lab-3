import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/theme/theme_cubit.dart';
import '../../../cubit/timeline/timeline_cubit.dart';
import '../../chatter/scope/chatter_scope.dart';
import 'summary/summary_chats_bottom_sheet.dart';

class SummaryChatSelectorButton extends StatelessWidget {
  const SummaryChatSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, tState) {
        return BlocBuilder<TimelineCubit, TimelineState>(
          builder: (_, state) {
            return IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(tState.primaryItemColor),
                ),
              ),
              onPressed: () => _showFloatChatsBottomSheet(context),
              icon: const Icon(Icons.chat),
            );
          },
        );
      },
    );
  }

  void _showFloatChatsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      builder: (context) {
        return SummaryChatsBottomSheet(
          chats: ChatterScope.of(context).state.chats,
        );
      },
    );
  }
}