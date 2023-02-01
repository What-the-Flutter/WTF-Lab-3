import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_state.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';

class EventSection extends StatelessWidget {
  final SettingState stateSetting;

  const EventSection({
    super.key,
    required this.stateSetting,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = context.read<SettingCubit>().isLight();

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stateSetting.listSection.length,
        itemBuilder: (context, index) {
          final items = stateSetting.listSection[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    context.read<EventCubit>().changeSectionIcon(
                          icon: items.iconSection,
                          sectionTitle: items.titleSection,
                        );
                  },
                  child: CircleAvatar(
                    backgroundColor: isLight ? AppColors.colorLightBlue : AppColors.colorLightGrey,
                    foregroundColor: Colors.white,
                    radius: 25,
                    child: Icon(items.iconSection),
                  ),
                ),
                Text(
                  items.titleSection,
                  style: TextStyle(
                    fontSize: context.read<SettingCubit>().state.textTheme.bodyText2!.fontSize,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
