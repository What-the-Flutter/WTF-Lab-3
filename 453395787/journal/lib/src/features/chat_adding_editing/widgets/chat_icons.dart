import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/insets.dart';
import '../cubit/manage_chat_cubit.dart';

part 'selectable_icon.dart';

class ChatIcons extends StatelessWidget {
  const ChatIcons({super.key});

  static const List<IconData> icons = [
    Icons.notes,
    Icons.work_outline,
    Icons.featured_play_list_outlined,
    Icons.family_restroom_outlined,
    Icons.abc_outlined,
    Icons.access_time_outlined,
    Icons.account_balance_outlined,
    Icons.airline_seat_individual_suite_outlined,
    Icons.anchor_outlined,
    Icons.announcement_outlined,
    Icons.architecture_outlined,
    Icons.article_outlined,
    Icons.assessment_outlined,
    Icons.assignment_turned_in_outlined,
    Icons.assistant_photo_outlined,
    Icons.attach_file_outlined,
    Icons.attach_money_outlined,
    Icons.audiotrack_outlined,
    Icons.auto_awesome_mosaic_outlined,
    Icons.auto_awesome_outlined,
    Icons.auto_awesome_motion_outlined,
    Icons.auto_graph_outlined,
    Icons.auto_stories_outlined,
    Icons.ac_unit_outlined,
    Icons.back_hand_outlined,
    Icons.badge_outlined,
    Icons.balance_outlined,
    Icons.beach_access_outlined,
    Icons.bedtime_outlined,
    Icons.bolt_outlined,
    Icons.book_outlined,
    Icons.bookmark_outline,
    Icons.border_color_outlined,
    Icons.brunch_dining_outlined,
    Icons.build_outlined,
    Icons.business_center_outlined,
    Icons.cake_outlined,
    Icons.calendar_month_outlined,
    Icons.call_outlined,
    Icons.camera_outlined,
    Icons.category_outlined,
    Icons.sports_volleyball_outlined,
    Icons.science_outlined,
    Icons.stadium_outlined,
    Icons.all_inclusive_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageChatCubit, ManageChatState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.all(Insets.medium),
          itemCount: icons.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            mainAxisSpacing: Insets.medium,
            crossAxisSpacing: Insets.medium,
          ),
          itemBuilder: (context, index) {
            return _SelectableIcon(
              index: index,
              icon: icons[index],
              isSelected: index == state.selectedIcon,
              onTap: (isSelected, index) {
                if (isSelected) {
                  context.read<ManageChatCubit>().onIconSelected(null);
                } else {
                  context.read<ManageChatCubit>().onIconSelected(index);
                }
              },
            );
          },
        );
      },
    );
  }
}
