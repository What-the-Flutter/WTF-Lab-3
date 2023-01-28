part of '../view/chat_settings_page.dart';

class _ChangeThemeItem extends StatelessWidget {
  const _ChangeThemeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
          leading: Icon(
            state.isDarkMode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            state.isDarkMode
                ? locale.Actions.switchToDayMode.i18n()
                : locale.Actions.switchToNightMode.i18n(),
            style: TextStyles.messageHighlighted(context).copyWith(
              fontSize: 16,
            ),
          ),
          onTap: () {
            context.read<ThemeCubit>().toggleDarkMode();
          },
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const ChoiceColorSheet(
                showExampleMessages: false,
              ),
            );
          },
        );
      },
    );
  }
}
