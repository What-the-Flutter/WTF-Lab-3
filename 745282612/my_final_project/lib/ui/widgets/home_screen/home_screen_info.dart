import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_inherited.dart';

class InfoPage extends StatelessWidget {
  final Icon icon;
  final String title;
  final DateTime dateCreate;
  final String dateLastEvent;

  const InfoPage({
    super.key,
    required this.dateCreate,
    required this.icon,
    required this.title,
    required this.dateLastEvent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomThemeInherited.of(context).isBrightnessLight();

    return AlertDialog(
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.colorLightBlue,
            foregroundColor: Colors.white,
            radius: 30,
            child: icon,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).created),
            Text(DateFormat.yMd().add_jm().format(dateCreate)),
            const SizedBox(
              height: 10,
            ),
            Text(S.of(context).last_event),
            Text(dateLastEvent),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: theme ? AppColors.colorLisgtTurquoise : AppColors.colorLightGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            S.of(context).ok,
            style: TextStyle(
              color: theme ? Colors.black : Colors.white,
            ),
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
