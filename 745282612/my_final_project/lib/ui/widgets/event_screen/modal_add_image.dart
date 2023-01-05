import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class MyDialog extends StatelessWidget {
  final String type;

  const MyDialog({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;

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
            color: theme ? AppColors.colorTurquoise : Colors.white,
          ),
          onPressed: () async {
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.camera,
            );
            context.read<EventCubit>().addPicterMessage(
                  pickedFile: pickedFile,
                  type: type,
                );
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Icon(
            Icons.picture_as_pdf,
            color: theme ? AppColors.colorTurquoise : Colors.white,
          ),
          onPressed: () async {
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            context.read<EventCubit>().addPicterMessage(
                  pickedFile: pickedFile,
                  type: type,
                );
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Icon(
            Icons.exit_to_app,
            color: theme ? AppColors.colorTurquoise : Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
