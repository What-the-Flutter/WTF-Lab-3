import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/repository/chat_repository.dart';
import '../../../common/data/provider/chat_provider.dart';
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
        chatRepository: ChatRepository(
          chatProvider: context.read<ChatProvider>(),
        ),
      ),
      child: child,
    );
  }

  static ChatOverviewCubit of(BuildContext context) {
    return context.read<ChatOverviewCubit>();
  }
}
