import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/models/chat.dart';
import '../../../common/utils/confirmation_dialog.dart';
import '../../../common/utils/floating_bottom_sheet.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/text_styles.dart';
import '../../navigation/cubit/navigation_cubit.dart';
import '../cubit/chat_overview_cubit.dart';
import '../widget/chat_item.dart';

part '../widget/bottom_action_sheet.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatOverviewCubit(
        repository: context.read<ChatRepository>(),
      ),
      child: BlocBuilder<ChatOverviewCubit, ChatOverviewState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.chats.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Insets.small,
                  horizontal: Insets.large,
                ),
                child: ChatItem(
                  chat: state.chats[index], // ordered chats here
                  onTap: () {
                    context
                        .read<NavigationCubit>()
                        .openChat(state.chats[index].id);
                  },
                  onLongPress: () {
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return _BottomActionSheet(
                          chat: state.chats[index],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
