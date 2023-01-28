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
    final isLight = context.watch<SettingCubit>().isLight();

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
                      child: Container(
                        width: 115,
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              context.watch<TimelineCubit>().isSelectedTag(listTags[i])
                                  ? Colors.green
                                  : isLight
                                      ? Colors.red
                                      : Colors.purple,
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<TimelineCubit>().changeFilterTags(listTags[i]);
                          },
                          child: Text(
                            listTags[i],
                            style: TextStyle(
                              fontSize:
                                  context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
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
