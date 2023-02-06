import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/chat_repository.dart';
import '../../cubit/chatter_cubit.dart';

class ChatterScope extends StatelessWidget {
  const ChatterScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatterCubit(
        repository: context.read<ChatRepository>(),
      ),
      child: child,
    );
  }

  static ChatterCubit of(BuildContext context) => context.read<ChatterCubit>();
}
