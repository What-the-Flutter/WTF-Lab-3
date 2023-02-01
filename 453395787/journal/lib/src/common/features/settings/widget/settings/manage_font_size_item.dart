part of '../../view/settings_page.dart';

class _ManageFontSizeItem extends StatelessWidget {
  const _ManageFontSizeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.text_fields_outlined,
      ),
      title: Text(
        locale.SettingsPage.fontSizeItem.i18n(),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const FontSizeSelector(),
        );
      },
    );
  }
}
