import 'package:flutter/material.dart';

import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/ui/widgets/home_screen/home_screen_info.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreenModal extends StatelessWidget {
  final Icon icon;
  final String title;
  final DateTime dateCreate;
  final String dateLastEvent;
  final int index;

  const HomeScreenModal({
    super.key,
    required this.icon,
    required this.title,
    required this.dateCreate,
    required this.dateLastEvent,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;
    final colorIcon = theme ? AppColors.colorNormalGrey : Colors.white;

    return Wrap(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, _, __) => InfoPage(
                  icon: icon,
                  dateCreate: dateCreate,
                  title: title,
                  dateLastEvent: dateLastEvent,
                ),
              ),
            );
          },
          child: ListTile(
            leading: Icon(
              Icons.info,
              color: colorIcon,
            ),
            title: Text(S.of(context).info),
          ),
        ),
        TextButton(
          onPressed: () {
            Provider.of<ChatProvider>(context, listen: false)
                .changePin(index: index);
            Navigator.pop(context);
          },
          child: ListTile(
            leading: Icon(
              Icons.attach_file,
              color: colorIcon,
            ),
            title: Text(S.of(context).pin_unpin),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: ListTile(
            leading: Icon(
              Icons.archive,
              color: colorIcon,
            ),
            title: Text(S.of(context).archive_page),
          ),
        ),
        TextButton(
          onPressed: () {
            Provider.of<ChatProvider>(context, listen: false).startEditeMode(
              title: title,
              index: index,
              icon: icon,
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNewScreen(),
              ),
            );
          },
          child: ListTile(
            leading: Icon(
              Icons.edit,
              color: colorIcon,
            ),
            title: Text(S.of(context).edit_page),
          ),
        ),
        TextButton(
          onPressed: () {
            Provider.of<ChatProvider>(context, listen: false)
                .deleteChat(index: index);
            Navigator.pop(context);
          },
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: colorIcon,
            ),
            title: Text(S.of(context).delete_page),
          ),
        ),
      ],
    );
  }
}
