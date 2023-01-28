import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_body.dart';

class TimelineFilter extends StatelessWidget {
  const TimelineFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).filter),
      ),
      body: const FilterBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () {
          context.read<TimelineCubit>().filterEventList();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
