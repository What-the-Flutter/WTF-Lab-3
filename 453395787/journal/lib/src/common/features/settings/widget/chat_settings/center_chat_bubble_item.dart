part of '../../view/chat_settings_page.dart';

class _CenterChatBubbleItem extends StatelessWidget {
  const _CenterChatBubbleItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.date_range_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        locale.SettingsPage.centerDateBubbleItem.i18n(),
        style: TextStyles.messageHighlighted(context).copyWith(
          fontSize: 16,
        ),
      ),
      trailing: Switch(
        value: context.watch<SettingsCubit>().state.isCenterDateBubbleShown,
        onChanged: (isToggle) {
          context.read<SettingsCubit>().changeBubbleDateVisibility(
                isToggle,
              );
        },
      ),
    );
  }
}
