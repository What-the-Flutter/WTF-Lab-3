import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/insets.dart';
import '../../cubit/tag_selector/tags_cubit.dart';
import '../../cubit/tag_selector/tags_state.dart';
import '../scopes/tags_scope.dart';
import 'tag_item.dart';

class TagSelector extends StatelessWidget {
  const TagSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsCubit, TagsState>(
      builder: (context, state) {
        return LimitedBox(
          maxHeight: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.tags.length,
            itemBuilder: (_, index) {
              var tag = state.tags[index];

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
            },
          ),
        );
      },
    );
  }
}
