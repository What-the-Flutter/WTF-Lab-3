part of '../../view/settings_page.dart';

class _ManageTagsItem extends StatelessWidget {
  const _ManageTagsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.tag_outlined,
      ),
      title: Text(
        locale.SettingsPage.tagItem.i18n(),
      ),
      onTap: () {
        context.go(
          Navigation.manageTagsPagePath,
        );
      },
    );
  }
}
