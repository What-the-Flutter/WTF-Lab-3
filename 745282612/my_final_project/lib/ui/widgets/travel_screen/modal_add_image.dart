import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class MyDialog extends StatelessWidget {
  final String type;
  final Function({
    required XFile? pickedFile,
    required String type,
  }) addPicter;

  const MyDialog({
    super.key,
    required this.type,
    required this.addPicter,
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
            Navigator.of(context).pop();
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.camera,
            );
            addPicter(
              pickedFile: pickedFile,
              type: type,
            );
          },
        ),
        TextButton(
          child: Icon(
            Icons.picture_as_pdf,
            color: theme ? AppColors.colorTurquoise : Colors.white,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            addPicter(
              pickedFile: pickedFile,
              type: type,
            );
            Provider.of<ChatProvider>(context, listen: false).isUpdate();
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
