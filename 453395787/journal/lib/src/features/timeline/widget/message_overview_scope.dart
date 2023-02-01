import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/provider/message_firebase_provider.dart';
import '../../../common/data/provider/storage_firebase_provider.dart';
import '../../../common/data/provider/tag_firebase_provider.dart';
import '../../../common/data/repository/message_overview_repository.dart';
import '../cubit/message_overview_cubit.dart';

class MessageOverviewScope extends StatelessWidget {
  const MessageOverviewScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MessageOverviewCubit>(
      create: (context) => MessageOverviewCubit(
        messageOverviewRepository: MessageOverviewRepository(
          messageProvider: context.read<MessageFirebaseProvider>(),
          tagProviderApi: context.read<TagFirebaseProvider>(),
          storageProvider: context.read<StorageFirebaseProvider>(),
        ),
      ),
      child: child,
    );
  }
}
