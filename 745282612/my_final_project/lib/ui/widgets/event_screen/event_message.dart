import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class EventMessage extends StatefulWidget {
  final Event event;

  const EventMessage({super.key, required this.event});

  @override
  State<EventMessage> createState() => _EventMessageState();
}

class _EventMessageState extends State<EventMessage> {
  Alignment messageBubbleAlignment() {
    final settingBubbleAlegnment = context.watch<SettingCubit>().state.bubbleAlignment;
    if (settingBubbleAlegnment == 'left') {
      return widget.event.messageType == 'sender' ? Alignment.bottomLeft : Alignment.bottomRight;
    } else {
      return widget.event.messageType == 'sender' ? Alignment.bottomRight : Alignment.bottomLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<SettingCubit>().isLight();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      alignment: messageBubbleAlignment(),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 2.5,
          minWidth: 100,
          minHeight: 80,
          maxHeight: double.infinity,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isLight
              ? widget.event.isSelected
                  ? Colors.blue
                  : AppColors.colorLisgtTurquoise
              : widget.event.isSelected
                  ? Colors.grey.shade400
                  : Colors.grey.shade700,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 3),
            widget.event.sectionIcon != null
                ? Row(
                    children: [
                      Icon(widget.event.sectionIcon),
                      Text(
                        widget.event.sectionTitle!,
                        style: TextStyle(
                          fontSize:
                              context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.bottomLeft,
              child: widget.event.messageImage != null
                  ? Image.network(widget.event.messageImage!)
                  : Text(
                      widget.event.messageContent,
                      style: TextStyle(
                        fontSize: context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
                      ),
                    ),
            ),
            const SizedBox(height: 3),
            widget.event.tag != null
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.event.tag!,
                      style: TextStyle(
                        color: AppColors.colorNormalGrey,
                        fontSize: context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: 3),
            Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('hh:mm a').format(widget.event.messageTime),
                    style: TextStyle(
                      color: AppColors.colorNormalGrey,
                      fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
                    ),
                  ),
                ),
                if (widget.event.isFavorit)
                  const Icon(
                    Icons.turned_in,
                    size: 15,
                    color: Colors.yellow,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
