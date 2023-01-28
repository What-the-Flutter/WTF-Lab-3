import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_instruction.dart';

class FilterByLabels extends StatelessWidget {
  const FilterByLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final listSection = context.watch<SettingCubit>().state.listSection;
    final isLight = context.watch<SettingCubit>().isLight();

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
                      child: Container(
                        width: 115,
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              context
                                      .watch<TimelineCubit>()
                                      .isSelectedSection(listSection[i].titleSection)
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
                            context
                                .read<TimelineCubit>()
                                .changeFilterSection(listSection[i].titleSection);
                          },
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
                                      .watch<SettingCubit>()
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
