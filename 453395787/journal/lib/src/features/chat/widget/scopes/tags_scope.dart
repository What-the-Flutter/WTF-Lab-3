import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/tag_selector/tags_cubit.dart';
import '../../cubit/tag_selector/tags_state.dart';

class TagSelectorScope extends StatelessWidget {
  const TagSelectorScope({
    super.key,
    required this.child,
    this.state,
  });

  final Widget child;
  final TagsState? state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagsCubit(
        state: state,
      ),
      child: child,
    );
  }

  static TagsCubit of(BuildContext context) {
    return context.read<TagsCubit>();
  }
}
