part of '../../view/settings_page.dart';

class _ManageSecurityItem extends StatelessWidget {
  const _ManageSecurityItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.security_outlined,
      ),
      title: Text(
        locale.SettingsPage.securityItem.i18n(),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => SecuritySettings(
            securityRepository: SecurityRepository(),
          ),
        );
      },
    );
  }
}
