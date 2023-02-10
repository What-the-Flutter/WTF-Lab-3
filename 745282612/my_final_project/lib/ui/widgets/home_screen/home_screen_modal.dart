import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
import 'package:my_final_project/ui/widgets/home_screen/home_screen_info.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class HomeScreenModal extends StatelessWidget {
  final String dateLastEvent;
  final Chat chat;

  const HomeScreenModal({
    super.key,
    required this.dateLastEvent,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<SettingCubit>().isLight();
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
                      chat: chat,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  color: colorIcon,
                ),
                title: Text(
                  S.of(context).info,
                  style: TextStyle(
                    fontSize: context.read<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<HomeCubit>().changePinChat(chat);
                Navigator.pop(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.attach_file,
                  color: colorIcon,
                ),
                title: Text(
                  S.of(context).pin_unpin,
                  style: TextStyle(
                    fontSize: context.read<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: ListTile(
                leading: Icon(
                  Icons.archive,
                  color: colorIcon,
                ),
                title: Text(
                  S.of(context).archive_page,
                  style: TextStyle(
                    fontSize: context.read<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<HomeCubit>().changeEditMode();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewScreen(
                      textController: chat.title,
                      chat: chat,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.edit,
                  color: colorIcon,
                ),
                title: Text(
                  S.of(context).edit_page,
                  style: TextStyle(
                    fontSize: context.read<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<HomeCubit>().deleteChat(chat);
                Navigator.pop(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.delete,
                  color: colorIcon,
                ),
                title: Text(
                  S.of(context).delete_page,
                  style: TextStyle(
                    fontSize: context.read<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
