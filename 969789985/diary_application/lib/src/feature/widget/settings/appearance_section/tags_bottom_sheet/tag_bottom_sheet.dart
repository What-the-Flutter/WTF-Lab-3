import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/datasource/source/tag_source.dart';
import '../../../../../core/data/repository/tag/tag_repository.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/settings/appearance_cubit.dart';
import 'tag_create_button.dart';
import 'tag_example.dart';
import 'tag_icons_grid_view.dart';
import 'tag_input_field.dart';

class TagBottomSheet extends StatelessWidget {
  const TagBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppearanceCubit(
        repository: TagRepository(
          provider: RepositoryProvider.of<TagSource>(context),
        ),
      ),
      child: BlocBuilder<AppearanceCubit, AppearanceState>(
          builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Insets.appConstantMedium),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 350.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(Radii.appConstant),
            ),
            child: Column(
              children: [
                TagIconsGridView(state: state),
                Padding(
                  padding:
                      const EdgeInsets.only(right: Insets.appConstantSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: TagInputField(),
                      ),
                      TagExample(state: state),
                      TagCreateButton(state: state),
                    ],
                  ),
                ),
                const SizedBox(height: Insets.medium)
              ],
            ),
          ),
        );
      }),
    );
  }
}
