import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_instruction.dart';

class FilterByLabels extends StatelessWidget {
  const FilterByLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final listSection = context.read<SettingCubit>().state.listSection;
    final isLight = context.read<SettingCubit>().isLight();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FilterInstruction(instructionText: 'label'),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 5,
              children: [
                for (int i = 0; i < listSection.length; i++)
                  if (listSection[i].titleSection == 'Cancel')
                    Container()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<TimelineCubit>()
                              .changeFilterSection(listSection[i].titleSection);
                        },
                        child: UnconstrainedBox(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: context
                                      .watch<TimelineCubit>()
                                      .isSelectedSection(listSection[i].titleSection)
                                  ? Colors.green
                                  : isLight
                                      ? Colors.red
                                      : Colors.purple,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(listSection[i].iconSection),
                                const SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  listSection[i].titleSection,
                                  style: TextStyle(
                                    fontSize: context
                                        .read<SettingCubit>()
                                        .state
                                        .textTheme
                                        .bodyText1!
                                        .fontSize,
                                  ),
                                ),
                              ],
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
