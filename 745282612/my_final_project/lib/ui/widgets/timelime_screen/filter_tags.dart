import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_instruction.dart';
import 'package:my_final_project/utils/constants/app_tags.dart';

class FilterByTags extends StatelessWidget {
  const FilterByTags({super.key});

  @override
  Widget build(BuildContext context) {
    final listTags = AppTags.tagsList;
    final isLight = context.read<SettingCubit>().isLight();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FilterInstruction(instructionText: 'tag'),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 5,
              children: [
                for (int i = 0; i < listTags.length; i++)
                  if (listTags[i] == 'Cancel')
                    Container()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          context.read<TimelineCubit>().changeFilterTags(listTags[i]);
                        },
                        child: UnconstrainedBox(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: context.watch<TimelineCubit>().isSelectedTag(listTags[i])
                                  ? Colors.green
                                  : isLight
                                      ? Colors.red
                                      : Colors.purple,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              listTags[i],
                              style: TextStyle(
                                fontSize: context
                                    .read<SettingCubit>()
                                    .state
                                    .textTheme
                                    .bodyText1!
                                    .fontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
