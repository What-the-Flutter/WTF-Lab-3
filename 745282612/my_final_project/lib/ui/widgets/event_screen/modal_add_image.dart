import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_cubit.dart';
import 'package:provider/provider.dart';

class MyDialog extends StatelessWidget {
  final String type;
  final int chatId;

  const MyDialog({
    super.key,
    required this.type,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeCubit>().isLight();

    return AlertDialog(
      title: Text(
        S.of(context).title_add_image,
      ),
      content: Text(
        S.of(context).content_add_image,
      ),
      actions: <Widget>[
        TextButton(
          child: Icon(
            Icons.camera_alt,
            color: isLight ? AppColors.colorTurquoise : Colors.white,
          ),
          onPressed: () async {
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.camera,
            );
            context.read<EventCubit>().addPicterMessage(
                  pickedFile: pickedFile,
                  type: type,
                  chatId: chatId,
                );
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Icon(
            Icons.picture_as_pdf,
            color: isLight ? AppColors.colorTurquoise : Colors.white,
          ),
          onPressed: () async {
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            context.read<EventCubit>().addPicterMessage(
                  pickedFile: pickedFile,
                  type: type,
                  chatId: chatId,
                );
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Icon(
            Icons.exit_to_app,
            color: isLight ? AppColors.colorTurquoise : Colors.white,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
