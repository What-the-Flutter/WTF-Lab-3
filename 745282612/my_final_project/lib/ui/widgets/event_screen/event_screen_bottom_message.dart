import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/modal_add_image.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class EventScreenBottomMessage extends StatefulWidget {
  final TextEditingController controller;
  final bool isCamera;

  const EventScreenBottomMessage({
    super.key,
    required this.controller,
    required this.isCamera,
  });

  @override
  State<EventScreenBottomMessage> createState() =>
      _EventScreenBottomMessageState();
}

class _EventScreenBottomMessageState extends State<EventScreenBottomMessage> {
  void eventOnLongPressed({
    required String editMessage,
    required String editText,
  }) {
    if (editMessage != '') {
      context.read<EventCubit>().editEvent(content: editText);
    } else if (widget.isCamera) {
      _showMyDialog('recipient');
    } else {
      context
          .read<EventCubit>()
          .addEvent(content: widget.controller.text, type: 'recipient');
      widget.controller.clear();
    }
  }

  void eventOnPressed({
    required String editMessage,
    required String editText,
  }) {
    if (editMessage != '') {
      context.read<EventCubit>().editEvent(content: editText);
    } else if (widget.isCamera) {
      _showMyDialog('sender');
    } else {
      context
          .read<EventCubit>()
          .addEvent(content: widget.controller.text, type: 'sender');
      widget.controller.clear();
    }
  }

  Future<void> _showMyDialog(String type) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return MyDialog(
          type: type,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.light;
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final editMessage = state.editText;
        late final editController = TextEditingController(text: editMessage);
        return Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          alignment: Alignment.bottomLeft,
          child: ColoredBox(
            color: theme ? Colors.white : Colors.black,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.bubble_chart,
                    size: 30,
                    color: theme ? AppColors.colorTurquoise : Colors.white,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller:
                        editMessage != '' ? editController : widget.controller,
                    decoration: const InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      labelText: 'Enter Event',
                    ),
                  ),
                ),
                TextButton(
                  onLongPress: () => eventOnLongPressed(
                    editMessage: editMessage,
                    editText: editController.text,
                  ),
                  onPressed: () => eventOnPressed(
                    editMessage: editMessage,
                    editText: editController.text,
                  ),
                  child: Icon(
                    editMessage != ''
                        ? Icons.send
                        : widget.isCamera
                            ? Icons.camera_enhance
                            : Icons.send,
                    size: 30,
                    color: theme ? AppColors.colorTurquoise : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
