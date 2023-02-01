part of '../../view/chat_settings_page.dart';

class _MessageAlignmentItem extends StatelessWidget {
  const _MessageAlignmentItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.format_align_left_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        locale.SettingsPage.bubbleAlignmentItemSubtitle.i18n(),
        style: TextStyles.messageHighlighted(context).copyWith(
          fontSize: 16,
        ),
      ),
      trailing: Switch(
        value: context.watch<SettingsCubit>().state.messageAlignment ==
            MessageAlignment.left,
        onChanged: (isToggle) {
          context.read<SettingsCubit>().changeMessageAlignment(
                isToggle ? MessageAlignment.left : MessageAlignment.right,
              );
        },
      ),
    );
  }
}
