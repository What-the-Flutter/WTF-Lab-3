import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/locale.dart' as locale;
import '../../../common/utils/text_styles.dart';
import '../cubit/settings_cubit.dart';

class ManageImageButtons extends StatelessWidget {
  const ManageImageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          child: SizedBox(
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
                    context
                        .read<SettingsCubit>()
                        .changeBackgroundImagePath(null);
                  },
                  child: Text(
                    locale.SettingsPage.removeBackgroundImage.i18n(),
                    style: TextStyles.bodyRed(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
