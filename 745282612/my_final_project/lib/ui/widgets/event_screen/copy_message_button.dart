import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';

class CopyMessageButton extends StatefulWidget {
  final List<Event> listMessage;

  const CopyMessageButton({
    super.key,
    required this.listMessage,
  });

  @override
  State<CopyMessageButton> createState() => _CopyMessageButtonState();
}

class _CopyMessageButtonState extends State<CopyMessageButton> {
  void copyMessage() async {
    late final String copyText;
    final index =
        widget.listMessage.indexWhere((element) => element.isSelected);
    widget.listMessage[index] = widget.listMessage[index].copyWith(
      isSelected: !widget.listMessage[index].isSelected,
    );
    copyText = widget.listMessage[index].messageContent;
    context.read<EventCubit>().changeSelected();

    await Clipboard.setData(
      ClipboardData(
        text: copyText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: copyMessage,
      child: const Icon(
        Icons.copy,
        color: Colors.white,
      ),
    );
  }
}
