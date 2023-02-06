part of '../../view/settings_page.dart';

class _ManageLanguagesItem extends StatelessWidget {
  const _ManageLanguagesItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.language_outlined,
      ),
      title: Text(
        locale.SettingsPage.languageItem.i18n(),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const LanguageSelector(),
        );
      },
    );
  }
}
