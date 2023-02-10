import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/repository/chat_repository.dart';
import '../../../common/data/repository/tag_repository.dart';
import '../../text_tags/data/text_tag_repository.dart';
import '../cubit/message_filter_cubit.dart';

class MessageFilterScope extends StatelessWidget {
  const MessageFilterScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageFilterCubit(
        tags: context.read<TagRepository>().tags.value,
        textTags: context.read<TextTagRepository>().textTags.value,
        chats: context.read<ChatRepository>().chats.value,
      ),
      child: child,
    );
  }
}
