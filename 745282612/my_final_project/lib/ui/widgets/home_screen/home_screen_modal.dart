import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
import 'package:my_final_project/ui/widgets/home_screen/home_screen_info.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_inherited.dart';

class HomeScreenModal extends StatelessWidget {
  final String dateLastEvent;
  final int index;
  final Chat chat;

  const HomeScreenModal({
    super.key,
    required this.dateLastEvent,
    required this.index,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = CustomThemeInherited.of(context).isBrightnessLight();
    final colorIcon = isLight ? AppColors.colorNormalGrey : Colors.white;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
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
                      icon: chat.icon,
                      dateCreate: chat.dateCreate,
                      title: chat.title,
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
                context.read<HomeCubit>().changePinChat(index);
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
                context.read<HomeCubit>().changeEditMode();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewScreen(
                      textController: chat.title,
                      editIndex: index,
                    ),
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
                context.read<HomeCubit>().deleteChat(index);
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
      },
    );
  }
}
