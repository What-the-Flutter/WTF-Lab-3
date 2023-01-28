import 'package:flutter/material.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/timeline_filter.dart';

class MainScreenFloatingButton extends StatelessWidget {
  final String menuStatus;

  const MainScreenFloatingButton({
    super.key,
    required this.menuStatus,
  });

  Widget floatingIcon() {
    if (menuStatus == 'timeline') {
      return const Icon(Icons.filter_list_sharp);
    } else {
      return const Icon(Icons.add);
    }
  }

  void floatingOnPressed(BuildContext context) {
    if (menuStatus == 'timeline') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const TimelineFilter(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AddNewScreen(
            textController: '',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: S.of(context).add_new_event,
      child: FloatingActionButton(
        child: floatingIcon(),
        onPressed: () {
          floatingOnPressed(context);
        },
      ),
    );
  }
}
