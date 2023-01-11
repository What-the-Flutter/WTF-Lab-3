import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';

class CopyMessageButton extends StatelessWidget {
  final List<Event> listMessage;

  const CopyMessageButton({
    super.key,
    required this.listMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<EventCubit>().copyClipboard,
      child: const Icon(
        Icons.copy,
        color: Colors.white,
      ),
    );
  }
}
