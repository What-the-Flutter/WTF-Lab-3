import 'package:flutter/material.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';

class MainScreenFloatingButton extends StatelessWidget {
  const MainScreenFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: S.of(context).add_new_event,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNewScreen(),
            ),
          );
        },
      ),
    );
  }
}
