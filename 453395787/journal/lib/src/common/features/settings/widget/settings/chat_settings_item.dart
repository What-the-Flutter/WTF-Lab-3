part of '../../view/settings_page.dart';

class _ChatSettingsItem extends StatelessWidget {
  const _ChatSettingsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.chat_outlined,
      ),
      title: Text(
        locale.SettingsPage.chatItem.i18n(),
      ),
      onTap: () async {
        context.go(Navigation.chatSettingsPagePath);
      },
    );
  }
}
