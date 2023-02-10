part of '../../view/chat_settings_page.dart';

class _ManageImageButton extends StatelessWidget {
  const _ManageImageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    context
                        .read<SettingsCubit>()
                        .changeBackgroundImagePath(image.path);
                  }
                },
                child: Text(
                  locale.SettingsPage.changeBackgroundImage.i18n(),
                ),
              ),
              TextButton(
                onPressed: () async {
                  context.read<SettingsCubit>().changeBackgroundImagePath(null);
                },
                child: Text(
                  locale.SettingsPage.removeBackgroundImage.i18n(),
                  style: TextStyles.bodyRed(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
