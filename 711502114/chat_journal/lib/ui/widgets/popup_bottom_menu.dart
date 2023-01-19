import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../provider/chat_provider.dart';
import '../pages/add_chat_page.dart';

class PopupBottomMenu extends StatelessWidget {
  final int index;

  const PopupBottomMenu({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final provider = Provider.of<ChatProvider>(context, listen: false);
    return Wrap(
      children: [
        TextButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          child: ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.greenAccent,
            ),
            title: Text(local?.infoChat ?? ''),
          ),
        ),
        TextButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          child: ListTile(
            leading: const Icon(
              Icons.attach_file,
              color: Colors.green,
            ),
            title: Text(local?.pinChat ?? ''),
          ),
        ),
        TextButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          child: ListTile(
            leading: const Icon(
              Icons.archive,
              color: Colors.yellow,
            ),
            title: Text(local?.archiveChat ?? ''),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddChatPage(
                chat: provider.chats[index],
                chatIndex: index,
              ),
            ));
          },
          child: ListTile(
            leading: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            title: Text(local?.editChat ?? ''),
          ),
        ),
        TextButton(
          onPressed: () {
            provider.delete(index);
            Navigator.pop(context);
          },
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
