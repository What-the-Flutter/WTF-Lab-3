import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/appearance_cubit.dart';
import 'tag_create_button.dart';
import 'tag_example.dart';
import 'tag_icons_grid_view.dart';
import 'tag_input_field.dart';

class TagBottomSheet extends StatelessWidget {
  const TagBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppearanceCubit(),
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
