import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/text_tag_multi_selector/text_tag_multi_selector_cubit.dart';
import '../data/text_tag_repository.dart';
import '../model/text_tag.dart';

class TextTagMultiSelectorScope extends StatelessWidget {
  const TextTagMultiSelectorScope({
    super.key,
    required this.child,
    this.selectedTextTags,
  });

  final IList<TextTag>? selectedTextTags;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextTagMultiSelectorCubit(
        selectedIds: selectedTextTags
            ?.map(
              (textTag) => textTag.id,
            )
            .toIList(),
        textTagRepository: context.read<TextTagRepository>(),
      ),
      child: child,
    );
  }
}
