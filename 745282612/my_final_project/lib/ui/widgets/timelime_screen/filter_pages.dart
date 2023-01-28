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
        Wrap(
          spacing: 5,
          children: [
            for (int i = 0; i < listChat.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Container(
                  width: 115,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        context.watch<TimelineCubit>().isSelectedChat(listChat[i].id)
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
                      context.read<TimelineCubit>().changeFilterPages(listChat[i].id);
                    },
                    child: Row(
                      children: [
                        listChat[i].icon,
                        const SizedBox(
                          width: 1,
                        ),
                        Text(
                          listChat[i].title,
                          style: TextStyle(
                            fontSize:
                                context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
