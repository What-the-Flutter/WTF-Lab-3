import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../../theme/theme_scope.dart';
import '../../scope/timeline_scope.dart';

class FilterChatterCardContent extends StatelessWidget {
  final ChatModel chat;

  const FilterChatterCardContent({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              IconData(chat.chatIcon, fontFamily: AppIcons.material),
              size: IconsSize.superExtraLarge,
              color: Theme.of(context).indicatorColor,
            ),
            const SizedBox(width: Insets.appConstantMedium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.chatTitle,
                  style: const TextStyle(fontSize: FontsSize.large),
                ),
                const SizedBox(height: Insets.small),
                Text(
                  chat.messages.isEmpty
                      ? 'Start this chat...'
                      : chat.messages.last.messageText,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).hintColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Spacer(),
            _SelectionCheckbox(chat: chat),
          ],
        ),
      ],
    );
  }
}

class _SelectionCheckbox extends StatelessWidget {
  final ChatModel chat;

  const _SelectionCheckbox({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.medium)
          ),
          activeColor: Color(ThemeScope.of(context).state.primaryColor),
          checkColor: Colors.white,
          value: state.map(
            defaultMode: (defaultMode) => false,
            filterMode: (filterMode) => filterMode.chatIds.contains(chat.id),
          ),
          onChanged: (value) {
            TimelineScope.of(context).updateSelectableChats(chat.id);
          },
        );
      },
    );
  }
}
