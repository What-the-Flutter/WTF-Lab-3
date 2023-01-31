import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_instruction.dart';

class FilterByPages extends StatefulWidget {
  const FilterByPages({super.key});

  @override
  State<FilterByPages> createState() => _FilterByPagesState();
}

class _FilterByPagesState extends State<FilterByPages> {
  @override
  Widget build(BuildContext context) {
    final listChat = context.watch<HomeCubit>().state.listChat;
    final isLight = context.watch<SettingCubit>().isLight();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FilterInstruction(instructionText: 'page'),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 5,
              children: [
                for (int i = 0; i < listChat.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        context.read<TimelineCubit>().changeFilterPages(listChat[i].id);
                      },
                      child: UnconstrainedBox(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: context.watch<TimelineCubit>().isSelectedChat(listChat[i].id)
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
                              listChat[i].icon,
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                listChat[i].title,
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
                          // ),
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
