import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/chat/message_control/message_control_cubit.dart';

class ChatAppBarLeading extends StatelessWidget {
  const ChatAppBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return context.watch<MessageControlCubit>().state.isSelectMode
        ? IconButton(
            onPressed: () {
              context.read<MessageControlCubit>().unselectAll();
            },
            icon: const Icon(Icons.close),
          )
        : IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          );
  }
}
