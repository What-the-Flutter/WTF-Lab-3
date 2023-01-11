import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/message_manage/message_manage_cubit.dart';
import '../../data/message_repository.dart';

class MessageManageScope extends StatelessWidget {
  const MessageManageScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageManageCubit(
        repository: context.read<MessageRepository>(),
      ),
      child: child,
    );
  }

  static MessageManageCubit of(BuildContext context) {
    return context.read<MessageManageCubit>();
  }
}
