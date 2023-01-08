import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/icons.dart';
import '../../../common/utils/insets.dart';
import '../cubit/manage_chat_cubit.dart';

part 'selectable_icon.dart';

class ChatIcons extends StatelessWidget {
  const ChatIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageChatCubit, ManageChatState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.all(Insets.medium),
          itemCount: JournalIcons.icons.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            mainAxisSpacing: Insets.medium,
            crossAxisSpacing: Insets.medium,
          ),
          itemBuilder: (context, index) {
            return _SelectableIcon(
              index: index,
              icon: JournalIcons.icons[index],
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
