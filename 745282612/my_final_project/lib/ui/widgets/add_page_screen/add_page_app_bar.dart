import 'package:flutter/material.dart';

import 'package:my_final_project/generated/l10n.dart';

class AddPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool status;

  const AddPageAppBar({
    super.key,
    required this.status,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        status ? S.of(context).edit_page : S.of(context).create_page,
      ),
      automaticallyImplyLeading: false,
    );
  }
}
