import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/insets.dart';
import '../../../common/utils/typedefs.dart';
import '../cubit/text_tag_multi_selector/text_tag_multi_selector_cubit.dart';

class TextTagMultiSelector extends StatelessWidget {
  const TextTagMultiSelector({
    super.key,
    this.onChanged,
  });

  final void Function(TextTagList tags)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextTagMultiSelectorCubit, TextTagMultiSelectorState>(
      listener: (context, state) {
        if (onChanged != null) {
          onChanged!(
            state.tags
                .where((tag) => state.selectedIds.contains(tag.id))
                .toIList(),
          );
        }
      },
      builder: (context, state) {
        return LimitedBox(
          maxHeight: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.tags.length,
            itemBuilder: (_, index) {
              final tag = state.tags[index];

              return Padding(
                padding: const EdgeInsets.all(
                  Insets.small,
                ),
                child: FilterChip(
                  label: Text(
                    tag.text,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onSelected: (_) {
                    context
                        .read<TextTagMultiSelectorCubit>()
                        .toggleSelection(tag);
                  },
                  selected: state.isSelected(tag),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
