import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/utils/constants/app_tags.dart';

class EventTag extends StatelessWidget {
  const EventTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppTags.tagsList.length,
        itemBuilder: (context, index) {
          final items = AppTags.tagsList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
              child: Text(
                items,
                style: TextStyle(
                  color: context.read<EventCubit>().state.tagTitle == items
                      ? Colors.green
                      : Colors.grey,
                  fontSize: context.read<SettingCubit>().state.textTheme.bodyText2!.fontSize,
                ),
              ),
              onPressed: () => context.read<EventCubit>().changeTagTitle(items),
            ),
          );
        },
      ),
    );
  }
}
