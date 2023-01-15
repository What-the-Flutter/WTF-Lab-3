import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: const Text('languages'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.tag_outlined),
            title: const Text('Tags'),
            onTap: () {
              context.go(PagePaths.manageTags.path);
            },
          ),
        ],
      ),
    );
  }
}
