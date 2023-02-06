import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/text_tag_cubit.dart';
import '../data/text_tag_repository.dart';

class TextTagSelectorScope extends StatelessWidget {
  const TextTagSelectorScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextTagCubit(
        textTagRepository: context.read<TextTagRepository>(),
      ),
      child: child,
    );
  }
}
