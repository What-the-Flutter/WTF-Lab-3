import 'package:flutter/material.dart';

import '../../../basic/providers/chat_list_provider.dart';
import '../../../widgets/chat_list/archive_list_view.dart';

class ArchiveChatScreen extends StatelessWidget {
  final ChatListProvider provider;

  ArchiveChatScreen({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive'),
        centerTitle: false,
      ),
      body: provider.repository.chats.where((el) => el.isArchive).isEmpty
          ? const Center(
              child: Text('Archive is empty'),
            )
          : ArchiveListView(
              provider: provider,
              archiveList: provider.repository.chats
                  .where((el) => el.isArchive)
                  .toList(),
            ),
    );
  }
}
