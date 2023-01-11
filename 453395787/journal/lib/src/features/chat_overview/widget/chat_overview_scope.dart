import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../cubit/chat_overview_cubit.dart';

class ChatOverviewScope extends StatelessWidget {
  const ChatOverviewScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatOverviewCubit(
        repository: context.read<ChatRepository>(),
      ),
      child: child,
    );
  }

  static ChatOverviewCubit of(BuildContext context) {
    return context.read<ChatOverviewCubit>();
  }
}
