import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/search/message_search_cubit.dart';
import '../../data/message_repository.dart';

class MessageSearchScope extends StatelessWidget {
  const MessageSearchScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageSearchCubit(
        repository: context.read<MessageRepository>(),
      ),
      child: child,
    );
  }

  static MessageSearchCubit of(BuildContext context) {
    return context.read<MessageSearchCubit>();
  }
}
