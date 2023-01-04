import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/modal_add_image.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/constants/app_section.dart';

class EventScreenBottomMessage extends StatefulWidget {
  final TextEditingController controller;
  final bool isCamera;

  const EventScreenBottomMessage({
    super.key,
    required this.controller,
    required this.isCamera,
  });

  @override
  State<EventScreenBottomMessage> createState() => _EventScreenBottomMessageState();
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
      context.read<EventCubit>().addEvent(content: widget.controller.text, type: 'recipient');
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
      context.read<EventCubit>().addEvent(content: widget.controller.text, type: 'sender');
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
        final sectionIcon = state.sectionIcon;
        late final editController = TextEditingController(text: editMessage);
        return Container(
          alignment: Alignment.bottomLeft,
          child: Container(
            alignment: Alignment.bottomLeft,
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: state.isSection
                  ? MediaQuery.of(context).size.height * 0.2
                  : MediaQuery.of(context).size.height * 0.1,
            ),
            child: ColoredBox(
              color: theme ? Colors.white : Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  state.isSection
                      ? Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: AppSection.listSection.length,
                            itemBuilder: (context, index) {
                              final items = AppSection.listSection[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.read<EventCubit>().changeSectionIcon(
                                              icon: items.iconSection,
                                              sectionTitle: items.titleSection,
                                            );
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: theme
                                            ? AppColors.colorLightBlue
                                            : AppColors.colorLightGrey,
                                        foregroundColor: Colors.white,
                                        radius: 25,
                                        child: Icon(items.iconSection),
                                      ),
                                    ),
                                    Text(items.titleSection),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => context.read<EventCubit>().changeSection(),
                        child: Icon(
                          sectionIcon,
                          size: 30,
                          color: theme ? AppColors.colorTurquoise : Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: editMessage != '' ? editController : widget.controller,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
