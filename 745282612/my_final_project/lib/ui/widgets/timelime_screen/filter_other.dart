import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';

class FilterOther extends StatelessWidget {
  const FilterOther({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.date_range),
            title: Text(
              S.of(context).jump_to_date,
              style: TextStyle(
                fontSize: context.read<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            trailing: Text(
              context.watch<TimelineCubit>().isSelectedDataTime()
                  ? DateFormat.yMMMEd().format(context.read<TimelineCubit>().state.filterDateTime!)
                  : 'None',
              style: TextStyle(
                fontSize: context.read<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2030),
              ).then(
                (value) {
                  if (value != null) {
                    context.read<TimelineCubit>().changeFilterDateTime(value);
                  }
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.image),
            title: Text(
              S.of(context).picture,
              style: TextStyle(
                fontSize: context.read<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            trailing: Text(
              context.read<TimelineCubit>().state.onlyPicture.toString(),
              style: TextStyle(
                fontSize: context.read<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            onTap: context.read<TimelineCubit>().changeStatusImage,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restore_outlined),
            title: Text(
              S.of(context).reset,
              style: TextStyle(
                fontSize: context.read<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            onTap: context.read<TimelineCubit>().resetFilter,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
