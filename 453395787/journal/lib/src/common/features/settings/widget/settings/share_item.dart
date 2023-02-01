part of '../../view/settings_page.dart';

class _ShareItem extends StatelessWidget {
  const _ShareItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.share_outlined,
      ),
      title: Text(
        locale.SettingsPage.shareItem.i18n(),
      ),
      onTap: () async {
        await Share.share(
          locale.SettingsPage.shareAppText.i18n(),
        );
      },
    );
  }
}
