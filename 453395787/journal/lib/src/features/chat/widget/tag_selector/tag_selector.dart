import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/models/ui/tag.dart';
import '../../../../common/utils/insets.dart';
import '../../../../routes.dart';
import '../../cubit/tag_selector/tags_cubit.dart';
import '../scopes/tags_scope.dart';
import 'tag_item.dart';

class TagSelector extends StatelessWidget {
  const TagSelector({
    super.key,
    this.isTagManageItemShown = true,
    this.onChanged,
  });

  final bool isTagManageItemShown;
  final void Function(IList<Tag> tags)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TagsCubit, TagsState>(
      listener: (context, state) {
        final selectedTags = state.map(
          initial: (_) => IList<Tag>([]),
          hasSelectedState: (hasSelectedState) => hasSelectedState.selected,
        );
        if (onChanged != null) {
          onChanged!(selectedTags);
        }
      },
      builder: (context, state) {
        return LimitedBox(
          maxHeight: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.tags.length + 1,
            itemBuilder: (_, index) {
              if (index != state.tags.length) {
                final tag = state.tags[index];

                return Padding(
                  padding: const EdgeInsets.all(
                    Insets.small,
                  ),
                  child: TagItem(
                    color: tag.color,
                    text: tag.text,
                    isSelected: state.isSelected(tag),
                    isEnabled: true,
                    onPressed: (_) =>
                        TagSelectorScope.of(context).toggleSelection(tag),
                  ),
                );
              }

              if (isTagManageItemShown) {
                return IconButton(
                  onPressed: () {
                    context.go(
                      Navigation.manageTagsPagePath,
                    );
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
