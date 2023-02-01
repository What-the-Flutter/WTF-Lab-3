import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/values/icons.dart';
import '../../../cubit/message_input/message_input_cubit.dart';

class TagCard extends StatelessWidget {
  final MessageInputState state;
  final int tagIndex;
  final int tagIcon;
  final String tagTitle;

  const TagCard({
    super.key,
    required this.tagIcon,
    required this.tagTitle,
    required this.tagIndex,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.circle),
        //border: Border.all(color: Theme.of(context).primaryColorLight),
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Radii.circle),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.circle),
          onTap: () {
            context.read<MessageInputCubit>().updateTag(tagIndex);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: Insets.small,
              bottom: Insets.small,
              left: Insets.small,
              right: Insets.medium,
            ),
            child: Row(
              children: [
                const SizedBox(width: Insets.small),
                Icon(
                  IconData(tagIcon, fontFamily: AppIcons.material),
                ),
                const SizedBox(width: Insets.small),
                Text(tagTitle),
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Radii.medium,
                    ),
                  ),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  activeColor: Theme.of(context).primaryColorLight,
                  splashRadius: 0.0,
                  checkColor: Colors.white,
                  value: state.tagSelected.containsKey(tagIndex)
                      ? state.tagSelected[tagIndex]
                      : false,
                  onChanged: (value) {
                    context.read<MessageInputCubit>().updateTag(tagIndex);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
