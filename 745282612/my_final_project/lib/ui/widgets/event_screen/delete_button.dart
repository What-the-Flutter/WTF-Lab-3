import 'package:flutter/material.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<EventCubit>().deleteEvent,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
