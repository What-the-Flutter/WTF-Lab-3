import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/data/provider/tag_firebase_provider.dart';
import '../../../../common/data/repository/tag_repository.dart';
import '../../../../common/models/ui/tag.dart';
import '../../cubit/tag_selector/tags_cubit.dart';

class TagSelectorScope extends StatelessWidget {
  const TagSelectorScope({
    super.key,
    required this.child,
    this.selectedTags
  });

  final Widget child;
  final IList<Tag>? selectedTags;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagsCubit(
        selectedTags: selectedTags,
        tagRepository: TagRepository(
          tagProvider: context.read<TagFirebaseProvider>(),
        ),
      ),
      child: child,
    );
  }

  static TagsCubit of(BuildContext context) {
    return context.read<TagsCubit>();
  }
}
