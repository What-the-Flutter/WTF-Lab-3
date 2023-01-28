import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/insets.dart';
import '../cubit/text_tag_cubit.dart';
import '../model/text_tag.dart';

part 'text_tag_chip.dart';

part 'text_tag_list.dart';

class TextTagSelector extends StatelessWidget {
  const TextTagSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextTagCubit, TextTagState>(
      builder: (context, state) {
        return state.map(
          initial: (initial) => const SizedBox(),
          success: (success) => _TextTagList(
            tags: success.tags,
            onPressed: context.read<TextTagCubit>().onTagPressed,
          ),
          addModeState: (addModeState) => Center(
            child: TextTagChip(
              tag: addModeState.tag,
            ),
          ),
          selectedState: (selectedState) => const SizedBox(),
        );
      },
    );
  }
}
