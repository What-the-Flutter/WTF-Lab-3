part of '../view/manage_chat_page.dart';

class ChatIconsGrid extends StatelessWidget {
  const ChatIconsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageChatCubit, ManageChatState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.all(
            Insets.medium,
          ),
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
                ManageChatScope.of(context)
                    .onIconSelected(isSelected ? null : index);
              },
            );
          },
        );
      },
    );
  }
}
