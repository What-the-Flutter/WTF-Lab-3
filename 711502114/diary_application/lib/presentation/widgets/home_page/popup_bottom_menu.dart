import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/presentation/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'chat_functions.dart';

class PopupBottomMenu extends StatelessWidget {
  final HomeCubit cubit;
  final Chat chat;

  const PopupBottomMenu({
    super.key,
    required this.cubit,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final list = _children(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return list[index];
      },
    );
  }

  List<Widget> _children(BuildContext context) {
    final local = AppLocalizations.of(context);
    final functions = ChatFunctions(
      context: context,
      cubit: cubit,
      chat: chat,
    );

    return [
      TextButton(
        onPressed: functions.showChatInfo,
        child: ListTile(
          leading: const Icon(
            Icons.info,
            color: Colors.greenAccent,
          ),
          title: Text(local?.infoChat ?? ''),
        ),
      ),
      TextButton(
        onPressed: functions.pinChat,
        child: ListTile(
          leading: const Icon(
            Icons.attach_file,
            color: Colors.green,
          ),
          title: Text(local?.pinChat ?? ''),
        ),
      ),
      TextButton(
        onPressed: functions.archiveChat,
        child: ListTile(
          leading: const Icon(
            Icons.archive,
            color: Colors.yellow,
          ),
          title: Text(local?.archiveChat ?? ''),
        ),
      ),
      TextButton(
        onPressed: functions.editChat,
        child: ListTile(
          leading: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          title: Text(local?.editChat ?? ''),
        ),
      ),
      TextButton(
        onPressed: functions.deleteChat,
        child: ListTile(
          leading: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          title: Text(local?.deleteChat ?? ''),
        ),
      ),
    ];
  }
}
