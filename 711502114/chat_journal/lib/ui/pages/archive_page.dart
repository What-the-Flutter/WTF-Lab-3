import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../provider/chat_provider.dart';
import '../../theme/colors.dart';
import '../widgets/home_page/chat_card.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local?.archiveChat ?? ''),
        centerTitle: true,
      ),
      body: _createMessagesList(provider),
    );
  }

  Widget _createMessagesList(ChatProvider provider) {
    final chats = provider.archivedChats;
    return ListView.separated(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatCard(
          chat: chats[index],
          extraWidget: _initArchiveButton(provider, index),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 1);
      },
    );
  }

  Widget _initArchiveButton(ChatProvider provider, int index) {
    return IconButton(
      onPressed: () {
        setState(() => provider.unarchive(index));
      },
      icon: Icon(Icons.archive, color: iconColor),
    );
  }
}
