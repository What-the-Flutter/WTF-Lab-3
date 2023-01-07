import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/models/chat.dart';
import '../../../common/utils/floating_bottom_sheet.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/radius.dart';
import '../../../common/utils/text_styles.dart';
import '../../navigation/cubit/navigation_cubit.dart';
import '../cubit/chat_overview_cubit.dart';
import 'bottom_action_sheet.dart';

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
            itemBuilder: (_, index) => ChatItem(
              chat: state.chats[index], // ordered chats here
            ),
          );
        },
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.small,
        horizontal: Insets.large,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Insets.small,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(Radius.large),
              onTap: () {
                context.read<NavigationCubit>().openChat(chat.id);
                /*
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      chatId: chat.id,
                    ),
                  ),
                );
                */
              },
              onLongPress: () {
                showFloatingModalBottomSheet(
                  context: context,
                  builder: ((context) {
                    return BottomActionSheet(
                      chat: chat,
                    );
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.large,
                  vertical: Insets.medium,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Insets.large,
                      ),
                      child: Icon(chat.icon),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                chat.name,
                                style: TextStyles.defaultMedium(context),
                              ),
                              Text(
                                chat.lastMessage != null
                                    ? chat.lastMessage!.time
                                    : '',
                                style: TextStyles.defaultGrey(context),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  chat.lastMessage != null
                                      ? chat.lastMessage!.text
                                      : 'Write your first message!',
                                  textAlign: TextAlign.start,
                                  style: TextStyles.defaultGrey(context),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ),
                              if (chat.isPinned)
                                const Icon(
                                  Icons.push_pin_outlined,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
