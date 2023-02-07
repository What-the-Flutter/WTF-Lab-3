import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_state.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/timeline_filter.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class MainScreenFloatingButton extends StatefulWidget {
  final MenuStatus menuStatus;

  const MainScreenFloatingButton({
    super.key,
    required this.menuStatus,
  });

  @override
  State<MainScreenFloatingButton> createState() => _MainScreenFloatingButtonState();
}

class _MainScreenFloatingButtonState extends State<MainScreenFloatingButton> {
  final _containerTransitionType = ContainerTransitionType.fade;

  Widget floatingIcon() {
    if (widget.menuStatus == MenuStatus.timeline) {
      return const Icon(
        Icons.filter_list_sharp,
        color: Colors.black,
      );
    } else {
      return const Icon(
        Icons.add,
        color: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: _containerTransitionType,
      transitionDuration: const Duration(seconds: 1),
      openBuilder: (context, _) => widget.menuStatus == MenuStatus.timeline
          ? const TimelineFilter()
          : const AddNewScreen(textController: ''),
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      closedColor: AppColors.colorLightYellow,
      closedBuilder: (context, _) => SizedBox(
        width: 60,
        height: 60,
        child: floatingIcon(),
      ),
    );
  }
}
