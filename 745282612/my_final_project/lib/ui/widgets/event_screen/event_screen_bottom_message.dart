import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_section.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_tags.dart';
import 'package:my_final_project/ui/widgets/event_screen/modal_add_image.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_state.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class EventScreenBottomMessage extends StatefulWidget {
  final TextEditingController controller;
  final bool isCamera;
  final int chatId;

  const EventScreenBottomMessage({
    super.key,
    required this.controller,
    required this.isCamera,
    required this.chatId,
  });

  @override
  State<EventScreenBottomMessage> createState() => _EventScreenBottomMessageState();
}

class _EventScreenBottomMessageState extends State<EventScreenBottomMessage> {
  late final TextEditingController editController;

  @override
  void initState() {
    editController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  void eventOnLongPressed({
    required String editMessage,
    required String editText,
  }) {
    if (editMessage != '') {
      context.read<EventCubit>().editEvent(content: editText);
    } else if (widget.isCamera) {
      context.read<EventCubit>().changeWrite();
      _showMyDialog('recipient');
    } else {
      context.read<EventCubit>().addEvent(
            content: widget.controller.text,
            type: 'recipient',
            chatId: widget.chatId,
          );
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
      context.read<EventCubit>().changeWrite();
      _showMyDialog('sender');
    } else {
      context.read<EventCubit>().addEvent(
            content: widget.controller.text,
            type: 'sender',
            chatId: widget.chatId,
          );
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
          chatId: widget.chatId,
        );
      },
    );
  }

  Widget sectionOrTag(EventState eventState, SettingState settingState) {
    if (eventState.switchSectionTag) {
      return eventState.isTag ? const EventTag() : Container();
    } else {
      return eventState.isSection
          ? EventSection(
              stateSetting: settingState,
            )
          : Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<SettingCubit>().isLight();

    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final stateSetting = context.watch<SettingCubit>().state;
        editController.text = state.editText;
        return Container(
          alignment: Alignment.bottomLeft,
          child: Container(
            alignment: Alignment.bottomLeft,
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: state.isSection || state.isTag
                  ? MediaQuery.of(context).size.height * 0.22
                  : MediaQuery.of(context).size.height * 0.1,
            ),
            child: ColoredBox(
              color: isLight ? Colors.white : Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  sectionOrTag(state, stateSetting),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          if (state.switchSectionTag) {
                            context.read<EventCubit>().changeStatusTag();
                          } else {
                            context.read<EventCubit>().changeSection();
                          }
                        },
                        onLongPress: context.read<EventCubit>().changeSwitchSectionTag,
                        child: Icon(
                          state.switchSectionTag ? Icons.tag : state.sectionIcon,
                          size: 30,
                          color: isLight ? AppColors.colorTurquoise : Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: state.editText != '' ? editController : widget.controller,
                          decoration: const InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            labelText: 'Enter Event',
                          ),
                        ),
                      ),
                      TextButton(
                        onLongPress: () => eventOnLongPressed(
                          editMessage: state.editText,
                          editText: editController.text,
                        ),
                        onPressed: () => eventOnPressed(
                          editMessage: state.editText,
                          editText: editController.text,
                        ),
                        child: Icon(
                          state.editText != ''
                              ? Icons.send
                              : widget.isCamera
                                  ? Icons.camera_enhance
                                  : Icons.send,
                          size: 30,
                          color: isLight ? AppColors.colorTurquoise : Colors.white,
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
