part of '../../view/settings_page.dart';

class _ResetAllItem extends StatelessWidget {
  const _ResetAllItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.refresh_outlined,
      ),
      title: Text(
        locale.SettingsPage.resetItem.i18n(),
      ),
      onTap: () async {
        final isConfirmed = await showConfirmationDialog(
          title: locale.SettingsPage.resetConfirmationTitle.i18n(),
          content: locale.SettingsPage.resetConfirmationSubtitle.i18n(),
          context: context,
        );

        if (isConfirmed != null && isConfirmed) {
          context.read<SettingsCubit>().resetToDefault();
          context.read<SecurityCubit>().resetToDefault();
          context.read<ThemeCubit>().resetToDefault();
          context.read<LocaleCubit>().resetToDefault();
        }
      },
    );
  }
}
