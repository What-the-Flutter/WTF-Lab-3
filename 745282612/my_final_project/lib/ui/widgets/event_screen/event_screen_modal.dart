import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class EventScreenModal extends StatefulWidget {
  final List<Event> listEvent;

  const EventScreenModal({
    super.key,
    required this.listEvent,
  });

  @override
  State<EventScreenModal> createState() => _EventScreenModalState();
}

class _EventScreenModalState extends State<EventScreenModal> {
  String selectedRadioTile = '';

  void setSelectedRadioTile(String val) {
    setState(
      () {
        selectedRadioTile = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text(S.of(context).event_modal_title),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.listChat.length,
              itemBuilder: (context, index) {
                final element = state.listChat[index];
                return RadioListTile(
                  value: element.title,
                  groupValue: selectedRadioTile,
                  title: Text(element.title),
                  onChanged: (val) => setSelectedRadioTile(val!),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: theme ? AppColors.colorLisgtTurquoise : AppColors.colorLightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).exit,
                style: TextStyle(
                  color: theme ? Colors.black : Colors.white,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: theme ? AppColors.colorLisgtTurquoise : AppColors.colorLightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).ok,
                style: TextStyle(
                  color: theme ? Colors.black : Colors.white,
                ),
              ),
              onPressed: () {
                context
                    .read<HomeCubit>()
                    .repetEvent(listEvent: widget.listEvent, title: selectedRadioTile);
                Navigator.of(context).pop();
                context.read<EventCubit>().deleteEvent();
              },
            ),
          ],
        );
      },
    );
  }
}
