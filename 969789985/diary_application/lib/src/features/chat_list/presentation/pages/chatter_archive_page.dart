import 'package:flutter/material.dart';

import '../widget/chatter_archive/chatter_archive_list/chatter_archive.dart';

class ArchiveChatScreen extends StatelessWidget {

  ArchiveChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive'),
        centerTitle: false,
      ),
      body: const ArchiveListView(),
    );
  }
}
