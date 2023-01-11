import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../cubit/manage_chat_cubit.dart';

class ManageChatScope extends StatelessWidget {
  const ManageChatScope({
    super.key,
    required this.child,
    required this.manageChatState,
  });

  final ManageChatState manageChatState;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageChatCubit(
        repository: context.read<ChatRepository>(),
        manageChatState: manageChatState,
      ),
      child: child,
    );
  }

  static ManageChatCubit of(BuildContext context) {
    return context.read<ManageChatCubit>();
  }
}
