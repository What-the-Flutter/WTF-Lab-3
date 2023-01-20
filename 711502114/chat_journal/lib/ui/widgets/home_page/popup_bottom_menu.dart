import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../provider/chat_provider.dart';
import 'chat_functions.dart';

class PopupBottomMenu extends StatelessWidget {
  final int index;

  const PopupBottomMenu({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final provider = Provider.of<ChatProvider>(context, listen: false);
    final functions = ChatFunctions(
      context: context,
      provider: provider,
      index: index,
    );
    return Wrap(
      children: [
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
      ],
    );
  }
}
